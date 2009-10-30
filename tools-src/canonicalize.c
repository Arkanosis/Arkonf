/* Return the canonical absolute name of a given file.
   Copyright (C) 1996-2007 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; see the file COPYING.
   If not, write to the Free Software Foundation,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */

/* This is not the original file!
   Modified by Jérémie Roquet <arkanosis@gmail.com> */

#define PATH_MAX 4096
#define SSIZE_MAX 4096
#define SIZE_MAX 8192
#define INITIAL_BUF_SIZE 1024

#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef ELOOP
# define ELOOP 0
#endif
#ifndef __set_errno
# define __set_errno(Val) errno = (Val)
#endif

int
readlink (const char *path, char *buf, int bufsize);
int
lstat (const char *path, struct stat *buf);

char *
areadlink (char const *filename)
{
  char initial_buf[INITIAL_BUF_SIZE];

  char *buffer = initial_buf;
  size_t buf_size = sizeof (initial_buf);

  while (1)
    {
      /* Attempt to read the link into the current buffer.  */
      ssize_t link_length = readlink (filename, buffer, buf_size);

      /* On AIX 5L v5.3 and HP-UX 11i v2 04/09, readlink returns -1
	 with errno == ERANGE if the buffer is too small.  */
      if (link_length < 0 && errno != ERANGE)
	{
	  if (buffer != initial_buf)
	    {
	      int saved_errno = errno;
	      free (buffer);
	      errno = saved_errno;
	    }
	  return NULL;
	}

      if ((size_t) link_length < buf_size)
	{
	  buffer[link_length++] = '\0';

	  /* Return it in a chunk of memory as small as possible.  */
	  if (buffer == initial_buf)
	    {
	      buffer = (char *) malloc (link_length);
	      if (buffer == NULL)
		/* errno is ENOMEM.  */
		return NULL;
	      memcpy (buffer, initial_buf, link_length);
	    }
	  else
	    {
	      /* Shrink buffer before returning it.  */
	      if ((size_t) link_length < buf_size)
		{
		  char *smaller_buffer = (char *) realloc (buffer, link_length);

		  if (smaller_buffer != NULL)
		    buffer = smaller_buffer;
		}
	    }
	  return buffer;
	}

      if (buffer != initial_buf)
	free (buffer);
      buf_size *= 2;
      if (SSIZE_MAX < buf_size || (SIZE_MAX / 2 < SSIZE_MAX && buf_size == 0))
	{
	  errno = ENOMEM;
	  return NULL;
	}
      buffer = (char *) malloc (buf_size);
      if (buffer == NULL)
	/* errno is ENOMEM.  */
	return NULL;
    }
}


char *
xgetcwd (void)
{
  size_t buf_size = INITIAL_BUF_SIZE;

  while (1)
    {
      char *buf = malloc (buf_size);
      char *cwd = getcwd (buf, buf_size);
      int saved_errno;
      if (cwd)
	return cwd;
      saved_errno = errno;
      free (buf);
      if (saved_errno != ERANGE)
	return NULL;
      buf_size *= 2;
      if (buf_size == 0)
	exit(42);
    }
}

char *
canonicalize_filename (const char *name)
{
  char *rname, *dest, *extra_buf = NULL;
  char const *start;
  char const *end;
  char const *rname_limit;
  size_t extra_len = 0;

  if (name == NULL)
    {
      __set_errno (EINVAL);
      return NULL;
    }

  if (name[0] == '\0')
    {
      __set_errno (ENOENT);
      return NULL;
    }

  if (name[0] != '/')
    {
      rname = xgetcwd ();
      if (!rname)
	return NULL;
      dest = strchr (rname, '\0');
      if (dest - rname < PATH_MAX)
	{
	  char *p = realloc (rname, PATH_MAX);
	  dest = p + (dest - rname);
	  rname = p;
	  rname_limit = rname + PATH_MAX;
	}
      else
	{
	  rname_limit = dest;
	}
    }
  else
    {
      rname = malloc (PATH_MAX);
      rname_limit = rname + PATH_MAX;
      rname[0] = '/';
      dest = rname + 1;
    }

  for (start = end = name; *start; start = end)
    {
      /* Skip sequence of multiple file name separators.  */
      while (*start == '/')
	++start;

      /* Find end of component.  */
      for (end = start; *end && *end != '/'; ++end)
	/* Nothing.  */;

      if (end - start == 0)
	break;
      else if (end - start == 1 && start[0] == '.')
	/* nothing */;
      else if (end - start == 2 && start[0] == '.' && start[1] == '.')
	{
	  /* Back up to previous component, ignore if at root already.  */
	  if (dest > rname + 1)
	    while ((--dest)[-1] != '/');
	}
      else
	{
	  struct stat st;

	  if (dest[-1] != '/')
	    *dest++ = '/';

	  if (dest + (end - start) >= rname_limit)
	    {
	      ptrdiff_t dest_offset = dest - rname;
	      size_t new_size = rname_limit - rname;

	      if (end - start + 1 > PATH_MAX)
		new_size += end - start + 1;
	      else
		new_size += PATH_MAX;
	      rname = realloc (rname, new_size);
	      rname_limit = rname + new_size;

	      dest = rname + dest_offset;
	    }

	  dest = memcpy (dest, start, end - start);
	  dest += end - start;
	  *dest = '\0';

	  if (lstat (rname, &st) != 0)
	    {
	      goto error;
	    }

	  if (S_ISLNK (st.st_mode))
	    {
	      char *buf;
	      size_t n, len;


	      buf = areadlink (rname);
	      if (!buf)
		{
		    goto error;
		}

	      n = strlen (buf);
	      len = strlen (end);

	      if (!extra_len)
		{
		  extra_len =
		    ((n + len + 1) > PATH_MAX) ? (n + len + 1) : PATH_MAX;
		  extra_buf = malloc (extra_len);
		}
	      else if ((n + len + 1) > extra_len)
		{
		  extra_len = n + len + 1;
		  extra_buf = realloc (extra_buf, extra_len);
		}

	      /* Careful here, end may be a pointer into extra_buf... */
	      memmove (&extra_buf[n], end, len + 1);
	      name = end = memcpy (extra_buf, buf, n);

	      if (buf[0] == '/')
		dest = rname + 1;	/* It's an absolute symlink */
	      else
		/* Back up to previous component, ignore if at root already: */
		if (dest > rname + 1)
		  while ((--dest)[-1] != '/');

	      free (buf);
	    }
	  else
	    {
	      if (!S_ISDIR (st.st_mode) && *end)
		{
		  errno = ENOTDIR;
		  goto error;
		}
	    }
	}
    }
  if (dest > rname + 1 && dest[-1] == '/')
    --dest;
  *dest = '\0';

  free (extra_buf);
  return rname;

error:
  free (extra_buf);
  free (rname);
  return NULL;
}

int
main (int argc, char *argv[])
{
  char* path;

  if (argc != 2)
  {
    fprintf (stderr, "Usage: canonicalize <path>\n");
    return 1;
  }

  path = canonicalize_filename (argv[1]);

  if (path)
    printf ("%s\n", path);

  free (path);

  return 0;
}

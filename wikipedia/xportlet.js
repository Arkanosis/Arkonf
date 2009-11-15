/*
********************************************************************
** xportlet - Fonctions de manipulation de l'interface mediawiki
** Compatibilité : mediawiki
** Support : Discussion_utilisateur:Arkanosis
** Licence : domaine public
**
** Installation : ajouter
**  importScript('Utilisateur:Arkanosis/xportlet.js');
** dans le script. Pour les développeurs uniquement.
*/

function newPortlet(parent, id, title, younger)
{
  var node = document.getElementById(parent);
  if (!node)
    return null;

  var portlet = document.createElement('div');
  portlet.setAttribute('class', 'generated-sidebar portlet');
  portlet.setAttribute('id', id);

  var titleNode = document.createElement('h5');
  titleNode.appendChild(document.createTextNode(title));
  portlet.appendChild(titleNode);

  var divNode = document.createElement('div');
  divNode.setAttribute('class', 'pBody');
  divNode.appendChild(document.createElement('ul'));
  portlet.appendChild(divNode);

  //if (younger)
  //  node.insertBefore(portlet, younger);
  //else
    node.appendChild(portlet);
}

function removePortlet(portlet)
{
  var node = document.getElementById(portlet);
  if (!node)
    return null;

  var parent = node.parentNode;
  if (!parent)
    return;

  parent.removeChild(node);
}

function removePortletLink(portlet, id)
{
  var node = document.getElementById(portlet);
  if (!node)
    return null;

  var parent = node.getElementsByTagName('ul')[0];
  var child = document.getElementById(id);
  if (!node || !child)
    return;

  parent.removeChild(child);
}

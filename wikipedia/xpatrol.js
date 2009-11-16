/*
********************************************************************
** xpatrol - Permet de patrouiller une révision sans changer de page
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
** Licence : domaine public
**
** Installation : ajouter
**  importScript('Utilisateur:Arkanosis/xpatrol.js');
** dans le monobook.js
*/

function patrol(url)
{
  spans = document.getElementsByTagName('span');
  for (var spanId = 0; spanId < spans.length; ++spanId)
    if (spans[spanId].className == 'patrollink')
    {
      var request = new XMLHttpRequest();
      request.open('GET', 'http://fr.wikipedia.org' + url, false);
      request.send('');
      spans[spanId].childNodes[1].innerHTML = '<img src="http://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Yes_check.svg/15px-Yes_check.svg.png" /> Révision marquée comme n\'étant pas un vandalisme';
      return;
    }
}

function xpatrol()
{
  if (location.href.indexOf('&diff') == -1)
    return;

  spans = document.getElementsByTagName('span');
  for (var spanId = 0; spanId < spans.length; ++spanId)
    if (spans[spanId].className == 'patrollink')
    {
      var link = spans[spanId].childNodes[1];
      url = link.getAttribute('href');
      link.setAttribute('href', 'javascript:patrol("' + url + '");');
      break;
    }
}

addOnloadHook(xpatrol);

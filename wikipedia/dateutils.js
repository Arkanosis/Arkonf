/*
********************************************************************
** dateutils - Fonctions de manipulation de dates
** Compatibilité : n'importe quel site
** Support : Discussion_utilisateur:Arkanosis
** Licence : domaine public
**
** Installation : ajouter
**  importScript('Utilisateur:Arkanosis/dateutils.js');
** dans le script. Pour les développeurs uniquement.
*/

function month(id)
{
  return  ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'][id];
}

function today()
{
  var day = new Date();
  return day.getDate() + " " + month(day.getMonth()) + " " + (1900 + day.getYear());
}

function yesterday()
{
  var day = new Date();
  day.setDate(day.getDate() - 1);
  return day.getDate() + " " + month(day.getMonth()) + " " + (1900 + day.getYear());
}

function tomorrow()
{
  var day = new Date();
  day.setDate(day.getDate() + 1);
  return day.getDate() + " " + month(day.getMonth()) + " " + (1900 + day.getYear());
}

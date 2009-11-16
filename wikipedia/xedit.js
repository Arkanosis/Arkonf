/*
********************************************************************
** xedit - Fonctions de manipulation de la zone de modification
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
** Licence : domaine public
**
** Installation : ajouter
**  importScript('Utilisateur:Arkanosis/xedi.js');
** dans le script. Pour les développeurs uniquement.
*/

function addNewCharSubset(title, chars)
{
  var specialChars = document.getElementById('specialcharsets');
    if (!specialChars)
      return;

  addSpecialCharset(title, chars);

  var opt = document.createElement("option");
  var txt = document.createTextNode(title);
  opt.appendChild(txt);
  specialChars.childNodes[0].appendChild(opt);
}

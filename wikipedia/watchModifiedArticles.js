/*
********************************************************************
** watchModifiedArticles - Ajoute automatiquement tous les articles modifiés dans la liste de suivi
** (et uniquement les articles encyclopédiques, si la préférence "Ajouter les pages que je
** modifie à ma liste de suivi" est désactivée)
** Compatibilité : mediawiki
** Support : Discussion_utilisateur:Arkanosis
** Licence : domaine public
**
** Installation : ajouter
**  importScript('Utilisateur:Arkanosis/watchModifiedArticles.js');
** dans le monobook.js
*/

function watchModifiedArticles()
{
  if (!wgNamespaceNumber && wgAction == 'edit')
    document.getElementById('wpWatchthis').setAttribute('checked', 'checked');
}

addOnloadHook(watchModifiedArticles);

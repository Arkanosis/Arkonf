/*
**************************************************
** Scripts maintenus par d'autres utilisateurs
*/

loadJs('User:EDUCA33E/LiveRC.js');

/*
**************************************************
** Paramètres de configuration
*/

var login = 'Arkanosis';

/*
**************************************************
** Fonctions maintenues par moi-même (domaine public)
** La dernière version se trouve sur cette page
** J'assure le support sur Discussion_utilisateur:Arkanosis
** Vous n'êtes pas obligé de mentionner ma contribution, mais si vous ne vous sentez pas capable d'aider un utilisateur qui voudrait personnaliser un peu ce code, un petit lien vers ma page de discussion serait sympa
*/

/*
** Cette fonction convertit un mois exprimé numériquement en français
** Compatibilité : n'importe quel site
** Support : Discussion_utilisateur:Arkanosis
*/
function month(id)
{
  return  ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'][id];
}

/*
** Cette fonction retourne la date courante sous la forme "jour mois année"
** Compatibilité : n'importe quel site
** Support : Discussion_utilisateur:Arkanosis
*/
function today()
{
  var day = new Date();
  return day.getDate() + " " + month(day.getMonth()) + " " + (1900 + day.getYear());
}

/*
** Cette fonction enregistre un script à exécuter au chargement de la page
** Compatibilité : n'importe quel site
** Support : Discussion_utilisateur:Arkanosis
*/
function addLoadEvent(fun)
{
  if (window.addEventListener)
    window.addEventListener('load', fun, false);
  else if (window.attachEvent)
    window.attachEvent('onload', fun);
}

/*
** Cette fonction crée un nouveau portlet
** Compatibilité : mediawiki
** Support : Discussion_utilisateur:Arkanosis
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

/*
** Cette fonction supprime un portlet
** Compatibilité : mediawiki
** Support : Discussion_utilisateur:Arkanosis
*/
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

/*
** Cette fonction supprime une entrée d'un portlet
** Compatibilité : mediawiki
** Support : Discussion_utilisateur:Arkanosis
*/
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

/*
**************************************************
** Scripts maintenus par moi-même (domaine public)
** La dernière version se trouve sur cette page
** J'assure le support sur Discussion_utilisateur:Arkanosis
** Vous n'êtes pas obligé de mentionner ma contribution, mais si vous ne vous sentez pas capable d'aider un utilisateur qui voudrait personnaliser un peu ce code, un petit lien vers ma page de discussion serait sympa
*/

/*
** Cette fonction ajoute deux onglets aux pages utilisateur (uniquement) pour voir les contributions et l'editcount du propriétaire de la page
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function ongletsUtilisateur()
{
  if (document.title.indexOf('Utilisateur:') != -1)
  {
    var utilisateur = document.title.replace('Utilisateur:', '').replace(' - Wikipédia', '');
    var editNode = document.getElementById('ca-edit');
    if (!utilisateur || !editNode)
      return;

    addPortletLink('p-cactions', '/wiki/Spécial:Contributions/' + utilisateur, 'contributions', 'ca-contrib', 'Voir les contributions de l\'utilisateur', 'o', editNode);
    addPortletLink('p-cactions', 'http://toolserver.org/~soxred93/count/index.php?name=' + utilisateur + '&lang=fr&wiki=wikipedia', 'editcount', 'ca-ecount', 'Voir l\'editcount de l\'utilisateur', 'n', editNode);
  }
}

/*
** Cette fonction ajoute deux liens en haut de page (à gauche de déconnexion) pour voir les créations et l'editcount de l'utilisateur courant
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function editCount()
{
  var decoNode = document.getElementById('pt-logout');
  if (!decoNode)
    return;

  addPortletLink('p-personal', 'http://toolserver.org/~escaladix/larticles/larticles.php?user=' + login + '&lang=fr', 'Créations', 'pt-ecount', 'Vos créations', 'r', decoNode);
  addPortletLink('p-personal', 'http://toolserver.org/~soxred93/count/index.php?name=' + login + '&lang=fr&wiki=wikipedia', 'Editcount', 'pt-ecount', 'Votre editcount', 'u', decoNode);
}

/*
** Cette fonction ajoute de nouveaux liens au menu de gauche qui sont utiles pour un contributeur régulier
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function liensUtiles()
{
  var hasardNode = document.getElementById('n-randompage');
  if (!hasardNode)
    return;

  addPortletLink('p-navigation', '/wiki/Wikipedia:Annonces', 'Annonces', 'n-annonces', 'Annonces', 'a', hasardNode);
  addPortletLink('p-navigation', '/wiki/Wikipedia:Le Bistro/' + today(), 'Bistrot du jour', 'n-bistrot', 'Bistrot du jour', 'b', hasardNode);
  addPortletLink('p-navigation', '/wiki/Wikipédia:Requête aux administrateurs', 'Requête aux administrateurs', 'n-ra', 'Requête aux administrateurs', 'r', hasardNode);
  addPortletLink('p-navigation', '/wiki/Spécial:Ma_page/Travaux à venir', 'Travaux à venir', 'n-travaux', 'Travaux à venir', 't', hasardNode);
  addPortletLink('p-navigation', '/wiki/Spécial:Ma_page/Presse-papiers', 'Presse-papiers', 'n-notes', 'Presse-papiers', 'p', hasardNode);

  newPortlet('column-one', 'p-rc', 'Patrouille RC', 'p-coll-create_a_book');
  addPortletLink('p-rc', '/wiki/Wikipédia:Patrouille_RC', 'Patrouille RC', 'r-patrouille', 'Patrouille RC');
  addPortletLink('p-rc', '/wiki/Utilisateur:EDUCA33E/LiveRC', 'Live RC', 'r-live', 'Live RC');
  addPortletLink('p-rc', '/w/index.php?limit=50&tagfilter=&title=Spécial%3AContributions&contribs=newbie&target=&namespace=0&year=&month=-1', 'Modifications récentes newbies', 'r-noob', 'Modifications récentes newbies');
  addPortletLink('p-rc', '/w/index.php?namespace=0&hideliu=1&title=Spécial%3AModifications+récentes', 'Modifications récentes IP', 'r-ip', 'Modifications récentes IP');
  addPortletLink('p-rc', '/wiki/Spécial:Nouvelles_pages', 'Nouvelles pages', 'r-newpage', 'Nouvelles pages');
  addPortletLink('p-rc', '/wiki/Spécial:Journal/newusers', 'Nouveaux utilisateurs', 'r-nuser', 'Nouveaux utilisateurs');

  newPortlet('column-one', 'p-proj', 'Projets', 'p-coll-create_a_book');
  addPortletLink('p-proj', '/wiki/Projet:Boîte Utilisateur', 'Boîte utilisateur', 'j-bu', 'Boîte utilisateur');
  addPortletLink('p-proj', '/wiki/Projet:Informatique', 'Informatique', 'j-info', 'Informatique');
  addPortletLink('p-proj', '/wiki/Projet:JavaScript', 'JavaScript', 'j-js', 'JavaScript');
  addPortletLink('p-proj', '/wiki/Projet:Jeu vidéo', 'Jeu vidéo', 'j-jv', 'Jeu vidéo');
  addPortletLink('p-proj', '/wiki/Projet:Modèle', 'Modèle', 'j-mod', 'Modèle');
  addPortletLink('p-proj', '/wiki/Projet:Musculation', 'Musculation', 'j-musc', 'Musculation');
  addPortletLink('p-proj', '/wiki/Projet:Musique électronique', 'Musique électronique', 'j-electro', 'Musique électronique');

  newPortlet('column-one', 'p-conf', 'Configuration', 'p-coll-create_a_book');
  addPortletLink('p-conf', '/wiki/Spécial:Préférences', 'Préférences', 'c-pref', 'Préférences');
  addPortletLink('p-conf', '/wiki/Spécial:Ma_page/monobook.js', 'monobook.js', 'c-js', 'monobook.js');
  addPortletLink('p-conf', '/wiki/Spécial:Ma_page/monobook.css', 'monobook.css', 'c-css', 'monobook.css');
  addPortletLink('p-conf', '/wiki/Spécial:Ma_page/LiveRCparam.js', 'LiveRC', 'c-live', 'LiveRC');
  addPortletLink('p-conf', '/wiki/Spécial:Ma_page/Editcounter', 'Editcounter', 'c-editcount', 'Editcounter');
}

/*
** Cette fonction retire les liens du menu de gauche qui sont inutiles pour un contributeur régulier
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function liensInutiles()
{
  // Barre du haut
  removePortletLink('p-personal', 'pt-preferences'); // Préférences

  // Navigation
  removePortletLink('p-navigation', 'n-thema'); // Portails thématiques
  removePortletLink('p-navigation', 'n-alphindex'); // Index alphabétique
  removePortletLink('p-navigation', 'n-contact'); // Contacter Wikipédia

  // Contribuer
  removePortlet('p-Contribuer');
}

/*
** Cette fonction ajoute de nouveaux onglets aux articles pour les blanchir plus rapidement
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function kitRc()
{
  // Liens test / autopromo / pas français pour les blanchiments RC
}


// Activation des modifications

addLoadEvent(ongletsUtilisateur);
addLoadEvent(editCount);
addLoadEvent(liensUtiles);
addLoadEvent(liensInutiles);
addLoadEvent(kitRc);
/*
**************************************************
** Configuration
*/
popupFixRedirs = true;
popupFixDabs = true;
popupEditCounterTool = 'perso';
popupEditCounterUrl = 'http://toolserver.org/~soxred93/count/index.php?name=$1&lang=fr&wiki=wikipedia';
popupAdjustDates = true;

/*
**************************************************
** Scripts maintenus par d'autres utilisateurs
*/

importScript('User:EDUCA33E/LiveRC.js');
importScript('User:Leag/popups-strings-fr.js');
importScript('en:User:Lupin/popups.js');

/*
**************************************************
** Scripts maintenus par moi-même (domaine public)
** La dernière version se trouve sur cette page
** J'assure le support sur Discussion_utilisateur:Arkanosis
** Vous n'êtes pas obligé de mentionner ma contribution, mais si vous ne vous sentez pas capable d'aider un utilisateur qui voudrait personnaliser un peu ce code, un petit lien vers ma page de discussion serait sympa
*/

// Pour les développeurs
importScript('Utilisateur:Arkanosis/dateutils.js');
importScript('Utilisateur:Arkanosis/xedit.js');
importScript('Utilisateur:Arkanosis/xportlet.js');

// Pour les utilisateur finaux
importScript('Utilisateur:Arkanosis/watchModifiedArticles.js');
importScript('Utilisateur:Arkanosis/xpatrol.js');

/*
** Cette fonction ajoute deux onglets aux pages utilisateur (uniquement) pour voir les contributions et l'editcount du propriétaire de la page
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function ongletsUtilisateur()
{
  if (document.title.indexOf('Utilisateur:') != -1 || document.title.indexOf('Discussion utilisateur:') != -1)
  {
    var utilisateur = document.title.replace('Utilisateur:', '').replace('Discussion utilisateur:', '').replace(' - Wikipédia', '').replace('Modification de ', '');
    var editNode = document.getElementById('ca-edit');
    if (!utilisateur || !editNode)
      return;

    addPortletLink('p-cactions', '/wiki/Spécial:Contributions/' + utilisateur, 'contributions', 'ca-contrib', 'Voir les contributions de l\'utilisateur', 'o', editNode);
    addPortletLink('p-cactions', 'http://toolserver.org/~soxred93/count/index.php?name=' + utilisateur + '&lang=fr&wiki=wikipedia', 'editcount', 'ca-ecount', 'Voir l\'editcount de l\'utilisateur', 'n', editNode);
    addPortletLink('p-cactions', 'http://fr.wikipedia.org/wiki/Wikipédia:Administrateur/' + utilisateur, 'admin', 'ca-admin', 'Voir la candidature de l\'utilisateur', 'a');
  }
}
addOnloadHook(ongletsUtilisateur);

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

  addPortletLink('p-personal', 'http://toolserver.org/~escaladix/larticles/larticles.php?user=' + wgUserName + '&lang=fr', 'Créations', 'pt-ecount', 'Vos créations', 'r', decoNode);
  addPortletLink('p-personal', 'http://toolserver.org/~soxred93/count/index.php?name=' + wgUserName + '&lang=fr&wiki=wikipedia', 'Editcount', 'pt-ecount', 'Votre editcount', 'u', decoNode);
}
addOnloadHook(editCount);

/*
** Cette fonction ajoute de nouveaux liens au menu de gauche qui sont utiles pour un contributeur régulier
** Compatibilité : frwiki uniquement (nécessite Utilisateur:Arkanosis/dateutils.js et Utilisateur:Arkanosis/xportlet.js)
** Support : Discussion_utilisateur:Arkanosis
*/
function liensUtiles()
{
  var hasardNode = document.getElementById('n-randompage');
  if (!hasardNode)
    return;

  addPortletLink('p-navigation', '/wiki/Wikipedia:Annonces', 'Annonces', 'n-annonces', 'Annonces', 'a', hasardNode);
  addPortletLink('p-navigation', '/wiki/Wikipedia:Le Bistro/' + today(), 'Bistro du jour', 'n-bistro', 'Bistro du jour', 'b', hasardNode);
  addPortletLink('p-navigation', '/wiki/Wikipedia:Le Bistro/' + yesterday(), 'Bistro de la veille', 'n-bistro-v', 'Bistro de la veille', 'v', hasardNode);
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
addOnloadHook(liensUtiles);

/*
** Cette fonction retire les liens du menu de gauche ou de la barre du haut qui sont inutiles pour un contributeur régulier
** Compatibilité : frwiki uniquement (nécessite Utilisateur:Arkanosis/xportlet.js)
** Support : Discussion_utilisateur:Arkanosis
*/
function liensInutiles()
{
  // Barre du haut
  removePortletLink('p-personal', 'pt-optin-try'); // Essayer la bêta Açai
  removePortletLink('p-personal', 'pt-preferences'); // Préférences

  // Navigation
  removePortletLink('p-navigation', 'n-thema'); // Portails thématiques
  removePortletLink('p-navigation', 'n-alphindex'); // Index alphabétique
  removePortletLink('p-navigation', 'n-contact'); // Contacter Wikipédia

  // Contribuer
  removePortlet('p-Contribuer');
}
addOnloadHook(liensInutiles);

/*
** Cette fonction retire la banière de pub de Wikimedia qu'on ne peut pas enlever autrement.
** Ne cache pas pour autant le siteNotice, des fois qu'il y ait quelque chose d'intéressant.
** Compatibilité : frwiki uniquement, spam de novembre 2009 uniquement
** Support : Non, pas de support pour celle-ci, débrouillez-vous sans moi
*/
function enleverSpam()
{
  if (wgNotice.indexOf('Pour une Wikipédia durable') != -1)
    wgNotice = '';
}
addOnloadHook(enleverSpam);

/*
** Cette fonction ajoute de nouveaux onglets aux articles pour les blanchir plus rapidement
** Compatibilité : frwiki uniquement
** Support : Discussion_utilisateur:Arkanosis
*/
function kitRc()
{
  // Liens test / autopromo / pas français pour les blanchiments RC
}
addOnloadHook(kitRc);

/*
** Cette fonction ajoute de nouveaux jeux de caractères spéciaux
** Compatibilité : frwiki uniquement (nécessite Utilisateur:Arkanosis/xedit.js)
** Support : Discussion_utilisateur:Arkanosis
*/
function nouveauxJeux()
{
  addNewCharSubset("Vieux Norrois", "Á á Ð ð Ì ì Í í Ò ò Ó ó Ú ú Ý ý Þ þ");
}
addOnloadHook(nouveauxJeux);

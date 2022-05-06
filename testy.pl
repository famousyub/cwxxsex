use warnings;
use strict;
use CGI;
use CGI::Carp 'fatalsToBrowser';
use File::Spec;
use PHP::Session;

# Nom de la session et répertoire où sont stockés les fichiers de session.
my $nom_session        = 'SessionPHP';
my $repertoire_session = 'user_id';

my $cgi = new CGI;

# Cookie
my $cookie = $cgi->cookie( -name => $nom_session );
my $fichier_session = File::Spec->catfile( $repertoire_session, 'sess_' . $cookie );

# Lecture ou création de la session
my $session = PHP::Session->new(
  $cookie,
  { save_path => $repertoire_session,
    auto_save => 1,
    create    => 1,
  }
);

my $bon_identifiant = 'test';
my $bon_motdepasse  = 'pass';

# Bouton connexion pressé
my $identifiant    = $cgi->param('identifiant');
my $motdepasse       = $cgi->param('motdepasse');
my $message_erreur = '';

# Bouton connexion pressé et connexion erronée
if (  $cgi->request_method() eq 'POST'
  and $cgi->param('connexion')
  and ( $identifiant ne 'test' or $motdepasse ne 'pass' ) )
{
  $message_erreur
    = "<p class='erreur center'>Erreur de connexion : identifiant ou mot de passe incorrect</p>";
}

# Bouton connexion pressé et connexion correcte
elsif ( $cgi->request_method() eq 'POST'
  and $cgi->param('connexion')
  and ( $identifiant eq 'test' or $motdepasse eq 'pass' ) )
{
  $session->set( identifiant => $identifiant );
  print $cgi->redirect('http://localhost:82/famousme/');
  exit;
}

# Session déjà existante et bonne
elsif ( $session->get('identifiant') and $session->get('identifiant') eq $bon_identifiant ) {
  print $cgi->redirect('http://localhost:82/famousme/');
  exit;
}
else {

  # Mauvaise session ou bouton connexion non pressé => page normale
}

print $cgi->header( -charset => 'utf-8', -lang => 'fr' );
print $cgi->start_html(
  -title => "Page d'accueil de connexion Perl",
  -style => { 'src' => '/sessions/style.css' },
);

print <<"RESUME";
    <h1 class="center">Accueil</h1>
    <p class="center">Merci de vous connecter avec votre identifiant (<i>test</i>) et votre
    mot de passe (<i>pass</i>).</p>

    <form accept="text/html" method="POST" accept-charset="utf-8" action="accueil.pl" name="formulaire">
    <table class="center">
     <tr>
      <td>Identifiant :</td>
      <td><input name="identifiant" type="text"></td>
     </tr>
     <tr>
      <td>Mot de passe :</td>
      <td><input name="motdepasse" type="password"></td>
     </tr>
     <tr>
      <td colspan="2" style="padding-top:20px;text-align:center;">
        <input name="connexion" type="submit" value="Se connecter">
      </td>
     </tr>
    </table>
    </form>
RESUME

if ( defined $message_erreur ) { print $message_erreur; }

print $cgi->end_html;

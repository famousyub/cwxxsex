package PForums;
use Dancer2;
use Dancer2::Plugin::DBIC;
use strict;
use warnings;
use Dancer2::Plugin::Passphrase;
use Crypt::Eksblowfish::Bcrypt "en_base64", "de_base64", "bcrypt_hash";
our $VERSION = '0.1';

set session => 'YAML';
use CGI::Lite;
use DBI;
use DDP;
use strict;
use PHP::Session;
use CGI::Lite;
use CGI;
my $dbh = DBI->connect('dbi:mysql:database=famousme;' . 'host=127.0.0.1;port=3306', 'root', '');
sub getsesionphp {


my $session_name = 'PHPSESSID'; # change this if needed

my $session_name2 ="user_id";
print "Content-type: text/plain\n\n";

my $cgi = new CGI::Lite;

my $cookies = $cgi->parse_cookies;
if ($cookies->{$session_name}) {
   my $session = PHP::Session->new($cookies->{$session_name});
   # now, try to print uid variable from PHP session
   print( "uuid");
   p Dumper($session->get('user_id'));
} else {
  print "can't find session cookie ";
   p $session_name;
}



my $cookies2 = $cgi->parse_cookies;
if ($cookies2->{$session_name}) {
   my $session2 = PHP::Session->new($cookies2->{$session_name});
   # now, try to print uid variable from PHP session
   print( "uuid");
   p Dumper($session2->get('user_id'));
} else {
  print "can't find session cookie ";
   p $session_name2;
}

#my $session = PHP::Session->new($id);

# session id
#my $id = $session->id;

# get/set session data
#my $foo = $session->get('user_id');
#p $foo ;
#$session->set(bar => $bar);

# remove session data
#$session->unregister('foo');

# remove all session data
#$session->unset;

# check if data is registered
#$session->is_registered('bar');

# save session data
#$session->save;

# destroy session
#$session->destroy;

# create session file, if not existent
#$session = PHP::Session->new($new_sid, { create => 1 });
};

get '/authorize:id?'  => sub {
   session user => param('id');
   session role     => 0;

};
get  '/me:id?' => sub {

my $cgi  = new CGI;
my $name = $cgi->cookie("username");
if ($name) { # if cookie is set
#redirect to authorised page
 p  $name;
}
else {
#redirect to unauthorised page
print  "undefiened";
}


my $sql1 = 'SELECT user_id , username,email,gender FROM `Wo_Users` WHERE user_id = ?';
my $sth1 = $dbh->prepare($sql1) or die $dbh->errstr;

$sth1->execute(param('id')) or die $sth1->errstr;

my $row1 = $sth1->fetchrow_hashref;
p $row1;
#print($password);
#print($row1->{password});

# session user => $row1->{user_id};
  if (param('id') == 0) {
      redirect '/me' . session('user');
  }

  my $mypage = undef;
  my $myrole = undef;

  if (param('id') == session('user')) {
      $mypage = 'true';
  }

  my $users = {};
  if (session('role') != 0) {
      $myrole = 'admin';

      my $sth = $dbh->prepare('SELECT username,email, user_id , gender FROM `Wo_Users` WHERE user_id!=?')
          or die $dbh->errstr;

    #  $sth->execute(session('user')) or die $sth->errstr;

      $users = $sth->fetchall_arrayref({}) or die $sth->errstr;
      p $users;
  }

  my $sql = 'SELECT user_id , username,email , user_id,gender , salt  FROM `Wo_Users` WHERE user_id=?';
  my $sth = $dbh->prepare($sql) or die $dbh->errstr;
  $sth->execute(param('id')) or die $sth->errstr;
#  $users = $sth->fetchall_arrayref({}) or die $sth->errstr;
#  p $users;
  my $row = $sth->fetchrow_hashref;
  warn 'get user' . param('id');

  use DDP;
  p $row;

  unless (defined $row) {
      status 'not_found';
      if (session('user') == param('id')) {
          session user => undef;
          session role => undef;
          redirect '/';
      }
      redirect '/404';
      return;
  }

  template 'me_page.tt',
  {
      'user_img' => 'img_src',
      'user_id' =>$row->{'user_id'},
      'username' => $row->{'username'},
      'email' => $row->{'email'},
      'salt' => $row->{'salt'},
      'gender' => $row->{'gender'},
      'my_user_page' => $mypage,
      'am_i_admin' => $myrole,
      'users' => $users,
  };


};



sub get_next_token {
    my $user_id = session('user');

    my $sql = 'SELECT user_id, username,email FROM `Wo_Users` where user_id=?';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($user_id) or die $sth->errstr;

    my $row = $sth->fetchrow_hashref;
    use Digest::SHA qw (sha256_hex);

    my $str = "";
    for (0..int(rand(25))) {
        $str .= $row->{email};
        $str .= $row->{username};
    }

    $str .= localtime();

    my $token = sha256_hex($str);
    $sql = 'UPDATE `Wo_Users` set salt=? where user_id=?';
    $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($token, $row->{user_id}) or die $sth->errstr;
    p $token;
}

get '/threads' => sub {
    my @threads = schema->resultset('Thread')->all();template 'index'   => {
         'title'   => 'PForums' ,
         'threads' => \@threads
    };
};

get '/test' => sub {
    template 'index' => { 'title' => 'PForums' };
};


post '/login' => sub {
    my $error;
    my $email = body_parameters->get('email');
    my $password = body_parameters->get('password');

    if ($email eq 'foo@foo.com' and $password eq '123456') {
        template 'login.tt', { message => 'User Validated. You can use any other template for successful redirection.'};
    }
    else {
        template 'login.tt', { message => 'Invalid user credentials.'};
    }
};










sub send_to_db {
    my $user_info = shift;
    return 0 unless defined $user_info;
    return 0 unless defined $user_info->{user_id};

    p $user_info;

    my $sql_first = 'UPDATE `Wo_Users` SET';
    my $sql_inner = '';
    my $sql_last = 'WHERE user_id=?';

    my @sql_params;

    if (defined $user_info->{username}) {

        my $sth_check = $dbh->prepare('SELECT user_id FROM `Wo_Users` WHERE username=?')
            or die $dbh->errstr;

        $sth_check->execute($user_info->{username})
            or die $sth_check->errstr;

        my $ans = $sth_check->fetchrow_hashref;
        return 0 if (defined $ans && $ans->{id} != session('user'));

        $sql_inner .= ' username=? ';
        push @sql_params, $user_info->{username};
    }
    if (defined $user_info->{email}) {

        my $sth_check = $dbh->prepare('SELECT user_id FROM `Wo_Users` WHERE email=?')
            or die $dbh->errstr;

        $sth_check->execute($user_info->{email})
            or die $sth_check->errstr;

        my $ans = $sth_check->fetchrow_hashref;
        return 0 if (defined $ans && $ans->{id} != session('user'));


        $sql_inner .= ' email=? ';
        push @sql_params, $user_info->{email};
    }

    if (session('role') == 0) {
        push @sql_params, session('user');
    }
    else {
        push @sql_params, $user_info->{user_id};
    }

    p @sql_params;

    my $sql = $sql_first . $sql_inner . $sql_last;
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute(values @sql_params) or die $sth->errstr;

    1;
}

hook before => sub {
    if (!session('user') &&
            (request->dispatch_path !~ m{^/auth} &&
             request->dispatch_path !~ m{^/reg})
        ) {
        redirect '/auth';
    }
    if (session('user')) {
        if (request->dispatch_path =~ m{^(/auth|/reg)}) {
            redirect '/user0';
        }
    }
};

get '/' => sub {
    if (session('user')) {
        redirect '/user0';
    }
    else {
        redirect '/auth';
    }
};

get '/reg' => sub {

    template 'reg.tt',
    {
        'csrf_value' => 123123,
    };
};

get '/auth' => sub {
  getsesionphp();

    template 'auth.tt',
    {
        'csrf_value' => 123123,
    };
};

get '/user:id?' => sub {

    if (param('id') == 0) {
        redirect '/user' . session('user');
    }

    my $mypage = undef;
    my $myrole = undef;

    if (param('id') == session('user')) {
        $mypage = 'true';
    }

    my $users = {};
    if (session('role') != 0) {
        $myrole = 'admin';

        my $sth = $dbh->prepare('SELECT * FROM `Wo_Users` WHERE user_id!=?')
            or die $dbh->errstr;

        $sth->execute(session('user'))
            or die $sth->errstr;

        $users = $sth->fetchall_arrayref({}) or die $sth->errstr;
        p $users;
    }

    my $sql = 'SELECT username,email , user_id,gender , salt  FROM `Wo_Users` WHERE user_id=?';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute(param('id')) or die $sth->errstr;

    my $row = $sth->fetchrow_hashref;
    warn 'get user' . param('id');

    use DDP;
    p $row;

    unless (defined $row) {
        status 'not_found';
        if (session('user') == param('id')) {
            session user => undef;
            session role => undef;
            redirect '/';
        }
        redirect '/404';
        return;
    }

    template 'user_page.tt',
    {
        'user_img' => 'img_src',
        'user_id' =>$row->{'user_id'},
        'user_nick' => $row->{'username'},
        'user_email' => $row->{'email'},
        'user_token' => $row->{'salt'},
        'my_user_page' => $mypage,
        'am_i_admin' => $myrole,
        'users' => $users,
    };
};



post '/user:id?' => sub {
    my $request_body = request->body();

    p $request_body;

    unless (session('user')) {
        status 'not_found';
        redirect '/404';
    }

    if ($request_body =~ m{^exit_button}) {
        session user => undef;
        session role => undef;
        redirect '/';
    }
    elsif ($request_body =~ m{^token_button}) {
        get_next_token();
        redirect '/';
    }
    elsif ($request_body =~ m{^home_button}) {
        redirect '/';
    }
    elsif ($request_body =~ m{change_button=Send$}) {

        my $res;

        if (param('change_nick')) {
            $res = send_to_db({username => param('change_nick'), user_id => params->{id}});
        }
        if (param('change_email')) {
            $res = send_to_db({email => param('change_email'), user_id => params->{id}});
        }

        if (param('change_password')) {
            $res = send_to_db({password => param('change_password'), user_id => params->{id}});
        }

        redirect '/user' . params->{id} if (session('role'));   # if admin
        redirect '/' if ($res);

        unless ($res) {
            session user => undef;
            session role => undef;
            redirect '/';
        }
    }
    else {
        redirect request->dispatch_path;
    }
};


sub   valide_pass {

 #my ($p1 ,$p2) = @_





 my ($pass_input,$bcrypt_hash_string ) = @_;

p $pass_input;
#p $bcrypt_hash_string;
# bcrypt hash string from password storage or other application
# e.g.  my $bcrypt_hash_string = qx{php -r 'echo password_hash($pass_input, PASSWORD_BCRYPT);'};
#my = $p2;

#my ( , $algorithm, $cost, $salt_and_pass ) = split /\$/, $bcrypt_hash_string;
#$unused,
  my ($algorithm, $cost, $salt_and_pass ) = grep length, split /\$/, $bcrypt_hash_string;

# 22 character salt (base64 encoded)
my $salt = substr $salt_and_pass, 0, 22;
# 31 character bcrypt hash (base64 encoded)
my $encoded_pass_hash = substr $salt_and_pass, 22, 31;

# Debug
#say "$algorithm, $cost, $salt_and_pass, $salt, $encoded_pass_hash";
#my $perl_bcrypt_hash = en_base64(
# Comput bcrypt hash using identified cost and salt
my $perl_bcrypt_hash = en_base64(
  bcrypt_hash(
      {
          cost    => $cost,
          key_nul => 1,
          salt    => de_base64($salt)
      },
      $pass_input
  )
);

# Method 1
# compare supplied bcrypt hash string from password storage
# with computed (Perl) bcrypt hash string
# Assemble (Perl) bcrypt hash string
my $perl_bcrypt_hash_string = sprintf '$%s$%d$%s%s', $algorithm, $cost, $salt, $perl_bcrypt_hash;
p $perl_bcrypt_hash_string;
my $psw_ver= substr  $perl_bcrypt_hash_string , 0 ,-7;
p $psw_ver ;
# Debug
#say "";
#say "Other $bcrypt_hash_string";
#say "Perl  $perl_bcrypt_hash_string";

if ( $bcrypt_hash_string eq $perl_bcrypt_hash_string ) {
#   say "Okay. Password hash strings match.";
   return 1;
} else {
#   say "Sorry. Password hash strings do not match";
   return 0;
}

# Method 2
# or compare encoded hashes
# Debug
#say "";
#say "Other $encoded_pass_hash";
#say "Perl  $perl_bcrypt_hash";
#if ( $encoded_pass_hash eq $perl_bcrypt_hash ) {
#   say "Okay. Password hashes match.";
#} else {
  # say "Sorry. Password hashes do not match";
 #}





}
post '/auth' => sub {
    my (@args) = @_;

    use DDP;
    # (email, password, sig)
    my $cgi  = new CGI;
    my $name = $cgi->cookie("user_id");
    if ($name) { # if cookie is set
    # redirect to authorised page
     p  $name;
    }
    else {
    # redirect to unauthorised page
    print  "undefiened";


    }
    my $email = params->{email};
    my $password = params->{password};
    my $sig = params->{sig};

    my $sql = 'SELECT user_id , username,email,avatar,password FROM `Wo_Users` WHERE email = ?';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute(params->{email}) or die $sth->errstr;

    my $row = $sth->fetchrow_hashref;
    p $row;
    print($password);
    print($row->{password});
#passphrase($password)->matches($row->{password})
my $r =  valide_pass($password,$row->{password});
p $r;
p $password;
    if (defined $row and $row->{email} eq $email and valide_pass($password,$row->{password}) eq 1)
    {
        session user => $row->{user_id};
      #  session role => $row->{role};
        redirect '/user' . $row->{user_id};
    }
    else {
        template 'auth',
        {
            'wrong_login_pass' => 'block',
        };
    }
};

post '/reg' => sub {
    my (@args) = @_;

    if (!params->{email} || !params->{username} || !params->{password}) {
        # empty fields
        return template 'reg',
        {
            'wrong_form_data' => 'block',
            'message' => 'You should fill all fields of form',
        };
    }

    if (params->{password} ne params->{passcheck})  {
        return template 'reg',
        {
            'wrong_form_data' => 'block',
            'message' => 'Passwords are not the same',
        };
    }


    my $sql = 'SELECT * FROM `Wo_Users` WHERE email=? or username=?';
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute(params->{email}, params->{username}) or die $sth->errstr;

    my $row = $sth->fetchrow_hashref;
    p $row;

    if (defined $row) {
        return template 'reg',
        {
            'wrong_form_data' => 'block',
            'message' => 'wrong something',
        };
    }
    my $pass = params->{password};
    my $php_pass = qx{php -r 'echo password_hash($pass, PASSWORD_BCRYPT);'};
    my ( $algorithm, $cost, $salt_pass ) = grep length, split /\$/, $php_pass;
 my $salt = substr $salt_pass, 0, 22;

 my $perl_hash = en_base64( bcrypt_hash({ cost => $cost,
                                          key_nul => 1,
                                          salt => de_base64($salt) },
                                        $pass ) );

 my $perl_pass = sprintf '$%s$%d$%s%s', $algorithm, $cost, $salt, $perl_hash;


    my $user_info = {
        username => params->{username},
        email => params->{email},
        password => $perl_pass,
        #passphrase(params->{password})->generate->rfc2307,
    };

    $sql = 'INSERT INTO `Wo_Users` (username,middle_name, email, password, salt) VALUES (?,?, ?, ?, ?)';
    $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute
    (
        $user_info->{username},
        $user_info->{middle_name},
        $user_info->{email},
        $user_info->{password},
        $user_info->{username} . $user_info->{email}
    ) or die $sth->errstr;

    $sql = 'SELECT user_id FROM `Wo_Users` WHERE username = ?';
    $sth = $dbh->prepare($sql) or die $dbh->errstr;
    $sth->execute($user_info->{username}) or die $dbh->errstr;

    $row = $sth->fetchrow_hashref;
    p $row;

    unless (defined $row) {
        return template 'reg',
        {
            'wrong_form_data' => 'block',
            'message' => '502. Internal Error!',
        };
    };

    get_next_token();

    session user => $row->{user_id};
    redirect '/user0';
};

get '/404' => sub {

};

dance();
true;

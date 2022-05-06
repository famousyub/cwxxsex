#!/usr/local/bin/perl -w
package MyServer;
use strict;
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);


my $port = 4569;


sub handle_request {
my ($self, $cgi) = @_;
return "Hi.";
}


my $pid = MyServer->new(4116)->background();


use LWP::UserAgent;

require HTTP::Request;
require HTTP::Headers;
use HTTP::Cookies;

$ua = LWP::UserAgent->new;


$request = HTTP::Request->new(GET => 'http://servername/iw-cc/iw-bin/show_env.cgi');
my $cookie_jar = HTTP::Cookies->new(
autosave => 0,
);
$cookie_jar->set_cookie(
1, # version
test, # key
testvalue, # value
'/', # path
'servername', # domain
'80' # port
# Few more optional parameters if needed
);
$ua->cookie_jar($cookie_jar);


$response = $ua->request($request);

# Check the outcome of the response
if ($response->is_success) {
print $response->content;
print "Success";
}
else {
print "Fail", "\n";
}

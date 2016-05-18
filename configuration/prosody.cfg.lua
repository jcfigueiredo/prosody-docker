admins = {
   "admin@localhost";
   "manager@localhost";
}


plugin_paths = { "/usr/lib/prosody/custom-modules/"}


modules_enabled = {
   "admin_adhoc";
   "admin_web";
   "dialback";
   "disco";
   "http";
   "http_files";
   "iq";
   "privacy";
   "private"; -- Private XML storage (for room bookmarks, etc.)
   "pubsub";
   "roster";
   "saslauth";
   "s2s";
   "tls";
   "vcard"; -- Allow users to set vCards
   "watchregistrations";

   "bosh";
   "legacyauth";
   "ping";
   "posix";
   "register";
   "time";
   "uptime";
   "version";

};

-- log = {
--        debug = "/var/log/prosody/prosody.log";
--        error = "/var/log/prosody/prosody.err";
-- }
log = {
    {
        levels = {min = "info"}, 
        to = "console"
    }
}

allow_registration = true;
authentication = "internal_hashed";
bosh_default_hold = 5;
bosh_max_inactivity = 30; -- 30 seconds
bosh_max_requests = 20;
consider_bosh_secure = true;
cross_domain_bosh = true;

daemonize = false;
pidfile = "/tmp/prosody.pid";

use_libevent = true;

bosh_ports = {
   {
      port = 5281;
      path = "http-bind";
   }
}

ssl = {
   key = "/etc/certs/localhost.key";
   certificate = "/etc/certs/localhost.crt";
}

https_ssl = {
   key = "/etc/certs/localhost.key";
   certificate = "/etc/certs/localhost.crt";
}

-- Wake Up Component
component_interface = "0.0.0.0"

Component "wakeup.localhost"
    component_secret = "xicabom"


VirtualHost "localhost"
-- Assign this host a certificate for TLS, otherwise it would use the one
-- set in the global section (if any).
-- Note that old-style SSL on port 5223 only supports one certificate, and will always
-- use the global one.

Component "conference.localhost" "muc"

restrict_room_creation = true
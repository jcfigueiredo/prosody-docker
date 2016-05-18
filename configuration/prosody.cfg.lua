admins = {
   "admin@localhost";
   "manager@localhost";
}

modules_enabled = {
   "admin_adhoc";
   "admin_web";
   "dialback";
   "component";
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

daemonize = true
pidfile = "/var/run/prosody/prosody.pid"


log = {
        debug = "/var/log/prosody/prosody.log";
        error = "/var/log/prosody/prosody.err";
}

allow_registration = true;
authentication = "internal_hashed";
bosh_default_hold = 5;
bosh_max_inactivity = 30; -- 30 seconds
bosh_max_requests = 20;
consider_bosh_secure = true;
cross_domain_bosh = true;
pidfile = "/var/run/prosody/prosody.pid";
use_libevent = true

bosh_ports = {
   {
      port = 5281;
      path = "http-bind";
   }
}

ssl = {
   key = "/etc/prosody/certs/key.pem";
   certificate = "/etc/prosody/certs/cert.pem";
}

https_ssl = {
   key = "/etc/prosody/certs/key.pem";
   certificate = "/etc/prosody/certs/cert.pem";
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
# robtimmer/cups

This Ubuntu-based Docker image runs a CUPS instance that is meant as a AirPrint relay for printers that are already on the network but not AirPrint capable.

## Configuration

### Volumes:
* `/data/config`: where the persistent printer configs will be stored
* `/data/services`: where the Avahi service files will be generated

### Variables:
* `USER`: the CUPS admin user you want created
* `PASSWORD`: the password for the CUPS admin user

### Ports:
* `631`: the TCP port for CUPS must be exposed

## Using
CUPS will be configurable at http://[server]:631 using the USER/ PASSWORD when you do something administrative.

If the `/data/services` volume isn't mapping to `/etc/avahi/services` then you will have to manually copy the .service files to that path at the command line.

## Notes
* CUPS doesn't write out `printers.conf` immediately when making changes even though they're live in CUPS. Therefore it will take a few moments before the services files update
* Don't stop the container immediately if you intend to have a persistent configuration for this same reason
#! perl

# Store this file as /usr/lib/urxvt/perl/xkr-clipboard
#
# To enable, add to ~/.Xresources:
#
# URxvt.perl-ext-common:        default,xkr-clipboard
# URxvt.iso14755:               false
# URxvt.keysym.Shift-Control-C: perl:clipboard:copy
# URxvt.keysym.Control-Insert:  perl:clipboard:copy
#
# Based on
#  https://wiki.archlinux.org/index.php/Rxvt-unicode#Custom_key_bindings
#  rxvt-unicode-9.19 / src/perl/clipboard-osc

sub on_user_command {
  my ($self, $osc, $resp) = @_;

  return unless $osc =~ s/^clipboard:([^;]+)//;

  if ($1 eq "copy") {
    my $text = $self->selection ();
    $self->selection ($text, 1);
    $self->selection_grab (urxvt::CurrentTime, 1);
  }

  1
}

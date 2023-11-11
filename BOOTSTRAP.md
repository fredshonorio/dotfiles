# Bootstraping

First begin by copying the ssh keys and config to `~.ssh`. Every thing should be `chown`ed by you and `chmod`ed to 600.

Then:

```
pamac upgrade
git clone https://github.com/fredshonorio/dotfiles.git .dotfiles
cd .dotfiles
./init.sh
```

After that xmonad might not work immediately (compilation will complain about a dbus module), so don't swap the xfce bits yet.

If this machine has an nvidia card install the proprietary drivers - got to Manjaro Settings Manager and click Hardware Configuration.

Now restart, that should fix xmonad. To check do `xmonad --recompile`, if that works then run `use-xmonad.sh`,
which will disable the xfce desktop, window manager and panel.

# Credentials

Use `pack.sh`/`unpack.sh` in `~/Sync`.

# Logging in

These things have to be setup manually:

- adding syncthing machines
- adding thunderbird email accounts (thunderbird knows server settings for mailbox and gmail)
- login to discord (QR code)
- firefox account

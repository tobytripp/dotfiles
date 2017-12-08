#!/usr/bin/python
import re, os

def get_password_emacs(machine, login, port):
    s = "machine %s login %s port %s password ([^ ]*)\n" % (machine, login, port)
    p = re.compile(s)
    authinfo = os.popen("gpg -q --no-tty -d ~/.emacs.d/secrets/.authinfo.gpg").read()
    return p.search(authinfo).group(1)


def main():
    get_password_emacs("imap.gmail.com", "ttripp@goldstarlearning.com", "993")

if __name__ == "__main__":
    main()

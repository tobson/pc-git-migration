#!/bin/sh

repo=${PWD}/google-code
hook=${repo}/hooks/pre-revprop-change

if [[ ! -d ${repo} ]]
then
  svnadmin create ${repo}
  echo '#!/bin/sh' > ${hook}
  echo 'exit 0' >> ${hook}
  chmod +x ${hook}
  svnsync initialize --username tobias.heinemann@gmail.com file://${repo} \
    http://pencil-code.googlecode.com/svn
fi

svnsync synchronize --username tobias.heinemann@gmail.com file://${repo}

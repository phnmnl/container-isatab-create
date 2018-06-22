FROM isatools/isatools:3.6-alpine-0.10.0

LABEL maintainer="PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )"
LABEL description="Tools to create ISA-Tab from experiment plans"
LABEL software.version="0.10.0"
LABEL version="0.5.0"
LABEL software="isatab-create"


RUN pip3 install click==6.7

RUN apk add --no-cache --virtual git-deps git openssh \
    && git clone --depth 1 --single-branch -b develop https://github.com/ISA-tools/isatools-galaxy /files/galaxy \
    && apk del git-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/*

ENV PATH=$PATH:/files/galaxy

ADD run_test.sh /usr/local/bin/run_test.sh
RUN chmod +x /usr/local/bin/run_test.sh

RUN cp /files/galaxy/tools/isacreate/isacreate.py /usr/local/bin/isacreate.py
RUN chmod a+x /usr/local/bin/isacreate.py

ENTRYPOINT ["isacreate.py"]

FROM isatools/isatools:3.6-alpine-0.9.5

LABEL maintainer="PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )"
LABEL description="Tools to create ISA-Tab from experiment plans"
LABEL software.version="0.9.5"
LABEL version="0.3.12"
LABEL software="isatab-create"

RUN pip3 install click==6.7
RUN pip3 uninstall isatools -y

RUN apk add --no-cache --virtual git-deps git openssh \
    && git clone --depth 1 --single-branch -b feature/pheno-cerebellin https://github.com/ISA-tools/isatools-galaxy /files/galaxy \
    && pip3 install git+git://github.com/ISA-tools/isa-api.git@feat/metabo_create_model#egg=isatools \
    && apk del git-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/*

ENV PATH=$PATH:/files/galaxy

ADD run_test.sh /usr/local/bin/run_test.sh
RUN chmod +x /usr/local/bin/run_test.sh

RUN cp /files/galaxy/tools/create_metabo/cli.py /usr/local/bin/cli.py
RUN chmod a+x /usr/local/bin/cli.py

ENTRYPOINT ["cli.py"]

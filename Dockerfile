FROM isatools/isatools:3.6-alpine-0.9.4

LABEL maintainer="PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )"
LABEL description="Tools to create ISA-Tab from experiment plans"
LABEL software.version="0.9.4"
LABEL version="0.3"
LABEL software="isatab-create"

RUN pip3 install click==6.7
RUN apk add --no-cache bash git openssh

RUN git clone --depth 1 --single-branch -b refactor https://github.com/ISA-tools/isatools-galaxy /files/galaxy

ENV PATH=$PATH:/files/galaxy

ADD run_test.sh /usr/local/bin/run_test.sh
ADD /files/galaxy/input_params.json /input_params.json
RUN chmod +x /usr/local/bin/run_test.sh

ADD /files/galaxy/cli.py /usr/local/bin/cli.py
RUN chmod a+x /usr/local/bin/cli.py

ENTRYPOINT ["cli.py"]

FROM isatools/isatools:3.6-alpine-0.9.3

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Tools to create ISA-Tab from experiment plans"
LABEL software.version="0.9.3"
LABEL version="0.1"
LABEL software="isatab-create"

RUN pip3 install click==6.7

ADD run_test.sh /usr/local/bin/run_test.sh
ADD input_params.json /input_params.json
RUN chmod +x /usr/local/bin/run_test.sh

ADD cli.py /usr/local/bin/cli.py
RUN chmod a+x /usr/local/bin/cli.py

ENTRYPOINT ["cli.py"]

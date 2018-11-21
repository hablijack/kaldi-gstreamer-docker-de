FROM jcsilva/docker-kaldi-gstreamer-server

RUN mkdir -p /opt/models && cd /opt/models && \
    wget --no-check-certificate http://speech.tools/kaldi_tuda_de/de_350k_nnet3chain_tdnn1f_1024_sp_bi.tar.bz2 && \
    tar xfvj de_350k_nnet3chain_tdnn1f_1024_sp_bi.tar.bz2 && \
    rm -f /opt/models/de_350k_nnet3chain_tdnn1f_1024_sp_bi.tar.bz2 && \
    find /opt/models/ -type f | xargs sed -i 's:de_350k_nnet3chain_tdnn1f_1024_sp_bi:/opt/models/de_350k_nnet3chain_tdnn1f_1024_sp_bi:g'

RUN apt-get update && \
    apt-get install -y supervisor && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]


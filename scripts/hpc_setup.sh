#!/bin/bash

#Install project repository
cd ~/bin
git clone https://github.com/duncanMR/wgs-variant-analysis wgs-project

#Install Python V3
sudo apt-get update -y
sudo apt-get install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
pyenv install 3.10.4

#Install R v4
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base
R --version

#install GATK
sudo apt-get install bcftools
wget https://github.com/broadinstitute/gatk/archive/refs/tags/4.2.6.1.zip
unzip 4.2.6.1.zip
echo 'export PATH="~/bin/gatk-4.2.6.1:$PATH"' >> ~/.bashrc
exec "$SHELL"
gatk --help

#Install VPOT
git clone https://github.com/VCCRI/VPOT.git VPOT

#install annovar to ~/bin using link sent by email
wget https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.openbioinformatics.org%2Fannovar%2Fdownload%2F0wgxR2rIVP%2Fannovar.latest.tar.gz&amp;data=05%7C01%7C%7Cd9f69cdea5f44340aeb208da32678933%7Ca6fa3b030a3c42588433a120dffcd348%7C0%7C0%7C637877717996492909%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=y1ou1tHl6%2Fb4mNueBwBe3t6SiRRxmRvlWV8yjmSeSxw%3D&amp;reserved=0
tar -xvzf annovar.latest.tar.gz
cd annovar
#install annovar annotation files
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar refGene humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar avnsp147 humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar dbnsfp42a humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar gnomad_exome humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar gnomad_genome humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar 1000g2015aug humandb/
./annotate_variation.pl -buildver hg38 -downdb -webfrom annovar clinvar_20220320 humandb/




import 'package:flutter/cupertino.dart';
import 'main.dart';

class Data extends ImageUploads {
  const Data({Key? key}) : super(key: key);

  void setData(){
    if(name== 'ECOLI'){
      path= 'assets/pdfs/Escherichia Coli.pdf';
      domain='Bacteria';
      phylum= 'Pseudomonadota';
      clas= 'Gammaproteobacteria';
      order= 'Enterobacterales';
      family= 'Enterobacteriaceae';
      genus= 'Escherichia';
      species= 'E. coli';
    }
    else if(name== 'PLASMODIUM FALCIPARUM'){
      path= 'assets/pdfs/Plasmodium Falciparum.pdf';
      domain='Eukaryota';
      phylum= 'Pseudomonadota';
      clas= 'Gammaproteobacteria';
      order= 'Enterobacterales';
      family= 'Enterobacteriaceae';
      genus= 'Escherichia';
      species= 'E. coli';
    }
    else if(name== 'SARS-CoV-2'){
      path= 'assets/pdfs/SARS-CoV-2.pdf';
      domain='Virus';
      phylum= 'Pisuviricota';
      clas= 'Pisoniviricetes';
      order= 'Nidovirales';
      family= 'Coronaviridae';
      genus= 'Betacoronavirus';
      species= 'SARS-CoV-2';
    }
    else if(name== 'STAPHYLOCOCCUS AUREUS'){
      path= 'assets/pdfs/Staphylococcus Aureus.pdf';
      domain='Bacteria';
      phylum= 'Bacillota';
      clas= 'Bacilli';
      order= 'Bacillales';
      family= 'Staphylococcaceae';
      genus= 'Staphylococcus';
      species= 'S. aureus';
    }
  }
}

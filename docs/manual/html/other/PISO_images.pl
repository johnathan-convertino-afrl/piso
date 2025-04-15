# LaTeX2HTML 2024 (Released January 1, 2024)
# Associate images original text with physical files.


$key = q/;MSF=1.6;AAT/;
$cached_env_img{$key} = q|<IMG
 STYLE="height: 0.23ex; vertical-align: -0.12ex; " SRC="|."$dir".q|PISO_img3.svg"
 ALT="$ $">|; 

$key = q/includegraphics[width=0.90textwidth,height=textheight,keepaspectratio]{imgslashAFRL.png};AAT/;
$cached_env_img{$key} = q|<IMG
 STYLE="height: 15.85ex; vertical-align: -0.12ex; " SRC="|."$dir".q|PISO_img1.svg"
 ALT="\includegraphics[width=0.90\textwidth,height=\textheight,keepaspectratio]{img/AFRL.png}">|; 

$key = q/includegraphics[width=textwidth]{srcslashdiagramsslashwaveform.png};MSF=1.6;AAT/;
$cached_env_img{$key} = q|<IMG
 STYLE="height: 57.86ex; vertical-align: -0.12ex; " SRC="|."$dir".q|PISO_img2.svg"
 ALT="\includegraphics[width=\textwidth]{src/diagrams/waveform.png}">|; 

1;


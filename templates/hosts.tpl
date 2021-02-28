[hosts]
%{ for ip in hosts ~}
${ip}
%{ endfor ~}

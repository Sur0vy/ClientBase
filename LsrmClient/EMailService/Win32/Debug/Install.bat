LsrmSend.exe /install /silent

sc.exe description LsrmMailSend "����뫪� E-Mail �� ���� ������"

sc.exe config LsrmMailSend depend= FirebirdServerDefaultInstance
rem ����ᨬ���� �� �ࢥ� ���� ��������� ⮫쪮 �� ���⠫�樨 �㦡� �� �� � �ࢥ஬.
rem ���� �� ��१���㧪� ��設� �㦡� ����� ���������� �����४⭮.

rem sc.exe failure LsrmMailSend reset= 30 actions= restart/60000/restart/60000/restart/60000 reboot= "���� �㦡� MailSubscribe"
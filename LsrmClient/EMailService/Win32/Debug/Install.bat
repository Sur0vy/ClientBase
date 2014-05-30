LsrmSend.exe /install /silent

sc.exe description LsrmMailSend "Рассылка E-Mail из базы данных"

sc.exe config LsrmMailSend depend= FirebirdServerDefaultInstance
rem Зависимость от сервера надо добавлять только при инсталяции службы на ПК с сервером.
rem Иначе при перезагрузке машины служба может запуститься некорректно.

rem sc.exe failure LsrmMailSend reset= 30 actions= restart/60000/restart/60000/restart/60000 reboot= "Сбой службы MailSubscribe"
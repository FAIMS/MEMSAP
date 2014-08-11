select uuid, group_concat(freetext) from latestnondeletedaentvalue group by uuid;
select * from localsettings;

update localsettings set value = 'II' where key = 'Area';

select sitevalue || '-'||areavalue || '-'||foo 
  from (select max(cast(replace(replace(freetext, site.value||'-', ''), area.value||'-','') as integer ) )+1 as foo, site.value as sitevalue, area.value as areavalue 
	  	 from latestnondeletedaentvalue join attributekey using (attributeid), (select value from localsettings where key = 'Site') site, (select value from localsettings where key = 'Area') area
		where uuid in (select uuid
						 from latestnondeletedaentvalue ae join localsettings on (value=freetext or value=vocabid) 
						 join latestnondeletedarchent using (uuid) join aenttype using (aenttypeid)
						where aenttypename = 'Context Group')
	      and attributename = 'Context Group ID');


select uuid, datetime(aentTimestamp, 'localtime') 
  from archentity 
 where uuid = 1000011402895918558
 group by uuid 
 having min(aenttimestamp);

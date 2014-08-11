select uuid, attributename, freetext
from  latestnondeletedarchent join aenttype using (aenttypeid) join idealaent using (aenttypeid) join attributekey using (attributeid) left outer join latestnondeletedaentvalue using (uuid, attributeid) left outer join vocabulary using (vocabid) 
where (freetext like '%%'
	   or vocabname like '%%'
       or measure like '%%'
       OR (freetext is null and vocabname is null and measure is null));


select uuid, attributename, coalesce(vocabname, 'No') = 'No'
from latestnondeletedaentvalue join attributekey using (attributeid) left outer join vocabulary using (vocabid) 
where attributename = 'Date Closed';


.schema archentity
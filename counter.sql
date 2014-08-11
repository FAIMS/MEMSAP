select uuid, aenttypename from latestnondeletedarchent join aenttype using (aenttypeid);

select count(distinct uuid) > 0
from latestnondeletedarchent left outer join latestnondeletedaentreln using (uuid) join relationship using (relationshipid) join relntype using (relntypeid) 
where relntypename='AboveBelow' and uuid = 1000011402635013937;




select sum(vocabname = 'Close') 
from latestnondeletedaentreln a join latestnondeletedarchent 
using (uuid) join aenttype using (aenttypeid) join latestnondeletedaentvalue using (uuid) join attributekey using (attributeid) join vocabulary using (vocabid) join latestnondeletedaentreln b using (relationshipid) 
where a.uuid != b.uuid 
and attributename = 'Scene Type' 
and b.uuid = 1000011402623491078 
group by b.uuid 
order by relationshipid;
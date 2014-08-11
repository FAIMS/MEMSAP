SELECT uuid, group_concat(coalesce(freetext, ''),'-') as response  
FROM (select * from latestNonDeletedArchentIdentifiers order by case attributename when 'Site Code' then 1 when 'AreaCode' then 2 when 'Grid Location Reference' then 3 when 'Context ID' then 4 else attributename end ) 
WHERE aenttypename = 'Context' 
and uuid in (select uuid 
               from latestnondeletedarchent join aenttype using (aenttypeid) join idealaent using (aenttypeid) join attributekey using (attributeid) 
               left outer join latestnondeletedaentvalue using (uuid, attributeid) 
               left outer join vocabulary using (vocabid)  
              where ('Search by LotID' != 'Search by LotID'
                      AND (freetext like '%123%' 
                           or vocabname like '%123%' 
                           or measure like '%123%' 
                           OR (freetext is null 
                               AND vocabname is null 
                               AND measure is null)) 
                      and ('Search by LotID' = 'All' OR 
                          (attributename = 'Search by LotID' and coalesce(vocabname, freetext, 'No') = 'No')) 
                      ) 
                OR (
                      'Search by LotID' = 'Search by LotID' AND
                      freetext = '123' AND
                      attributename = 'LotID'
                      )
                )
GROUP BY uuid 
order by response;
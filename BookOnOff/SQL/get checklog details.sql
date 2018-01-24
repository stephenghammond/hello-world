select ro_shift_start, ro_shift_length,of_forenames, of_surname, cl_method,checklog.* 
from checklog left outer join officer on of_pin=cl_officer
INNER JOIN roster on ro_shiftid=cl_shiftid
order by of_surname
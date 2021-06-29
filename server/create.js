const {p_arr}=require("./create_p")
const {loc_arr}=require("./create_loc")
const {airline_info_arr}=require("./create_air")
const {db}=require("./db")

var sql=`insert into person (id,fullname,telephone,idno) values ?`
db(sql,[p_arr]).then(()=>{
    sql = `insert into location (id,location_name) values ?`
    db(sql, [loc_arr]).then(()=>{
        sql='insert into airline_info (id,flight_id,capacity,s_time,e_time,s_loc_id,e_loc_id,price) values ?'
        db(sql, [airline_info_arr]).catch(err => {
            console.log("创建 AIRLINE_INFO ERR")
        })
    })
    .catch(err => {
        console.log("创建LOCATION ERR")
    })
}).catch(err=>{console.log("创建PERSON ERR")})
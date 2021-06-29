const mysql = require('mysql')
const config = {
    database: 'flight_sys',
    host:"127.0.0.1",
    port:"3306",
    user: 'root',
    password:'123456'
}


const pool = mysql.createPool(config)
exports.db = (sql, sqlParams) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, conn) => {
            if (!err) {
                conn.query(sql, sqlParams, (e, results) => {
                    if (!e) {
                     //   console.log(results)
                        resolve(results)
                        conn.destroy()
                    } else {
                        console.log('sql',e.toString().slice(0,100))
                        reject(e)
                    }
                })
            } else {
                console.log('conn err', err)
                reject(err)
            }
                 
        })
    })
}
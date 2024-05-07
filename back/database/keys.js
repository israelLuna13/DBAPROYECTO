const {Pool} =require('pg');
const pool = new Pool({
    // host:'10.219.138.194',
    // port:'5433',
    // user:'omartapia',
    // password:null,
    // database:'postgres' 
    host:'localhost',
    port:'5433',
    user:'israelcastanedaluna',
    password:null,
    database:'teclag' 
})

module.exports=pool;
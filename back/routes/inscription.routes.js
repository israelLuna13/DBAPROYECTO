const express =require ('express');
const inscription =require ('../controllers/inscription');

const router = express.Router();
//obtener datos de la tabla del kardex
router.post('/kardex', inscription.getkardex);

module.exports=router; 

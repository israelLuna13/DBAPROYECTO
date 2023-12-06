const express =require ('express');
const inscription =require ('../controllers/inscription');

const router = express.Router();
//obtener datos de la tabla del kardex
router.post('/kardex', inscription.getkardex);
router.get('/inscription/:id_a', inscription.inscription);
router.get('/reinscription/:id_a', inscription.materias_pasadas);
router.get('/reinscription/:id_a/reprobada', inscription.materias_reprobadas);

module.exports=router; 

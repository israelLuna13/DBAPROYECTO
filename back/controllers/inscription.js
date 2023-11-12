const pool = require('../database/keys');

const inscription = {};

inscription.getkardex = async (req, res) => {
    //obtenemos el num de control
    const { control } = req.body;
  
    try {
        //hacemos una consulta a la tabla de kardex
      const kardex = (await pool.query(
        'SELECT control_a, fkalumno_k FROM kardex INNER JOIN alumnos ON kardex.fkalumno_k = control_a where fkalumno_k= $1;',
        [control])).rows;
  
        //validamos si hay algun registro en la constante
      if (kardex.length > 0) {
        //quiere decir que es una reeinscripcion
        res.status(200).json({
          control_a: kardex[0].control_a,
          fkalumno_k: kardex[0].fkalumno_k,
        });
        //si no hay registros
      } else {
        //no se encontro en la tabla kardex
        //quiere decir que se va a inscribir

        res.status(404).json({
          control_a:control,
        });
      }
      // si hay un error
    } catch (error) {
      console.error('Error:', error);
      res.status(500).json({
        message: 'Error en el servidor',
        error: error.message,
      });
    }
  };
  
module.exports = inscription;

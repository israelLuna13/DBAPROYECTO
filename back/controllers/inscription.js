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

  
inscription.inscription = async(req,res)=>{
  const id = req.params.userId;

  // Realizar acciones con el parámetro id, como consultar en la base de datos
  // y enviar una respuesta al cliente
  //res.json({ mensaje: `Solicitud GET para inscription con ID ${id}` });
try {
  let semestre = 1
  const  grupos = (await pool.query(
    'select * from grupo where fksemestre_g = $1;',
    [semestre])).rows;

    if (grupos.length > 0) {
      res.status(200).json({
        grupos:grupos
        // clave_grupo:grupos[1].cve_g,
        // personal:grupos[1].fkpersonal_g,
        // materia:grupos[1].fkmateria_g,
      })
      //console.log(res)

    }
    //console.log(grupos)
    }
 catch (error) {
  console.error('Error:', error);
  res.status(500).json({
    message: 'Error en el servidor',
    error: error.message,
  });
}

}  
module.exports = inscription;

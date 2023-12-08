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
  let cvegrupo = 'A'
  const  grupos = (await pool.query(
    ' select cve_g,nombre_m,nombre_per from grupo join personal on grupo.fkpersonal_g = personal.cve_per join materia on  materia.cve_m = grupo.fkmateria_g where fksemestre_g = $1 and cve_g = $2;',
    [semestre,cvegrupo])).rows;

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

inscription.materias_reprobadas = async(req,res)=>{
  //materias aprobadas en primeras y segundas 
  try {
   // const id = req.params.userId;
    let cali = 7

//    const ligada = (await pool.query('SELECT nombre_m FROM prerrequisitos INNER JOIN materia ON materia.cve_m = prerrequisitos.cvemateria_pre WHERE fkmateria_pre IN (SELECT fkmateria_kFROM kardex INNER JOIN materia ON kardex.fkmateria_k = materia.cve_m WHERE calificacionp_k < $1 AND calificacionr_k < $1);',[cali])).rows

    const materias = ( await pool.query('SELECT cve_m, nombre_m FROM kardex INNER JOIN materia ON kardex.fkmateria_k = cve_m WHERE calificacionp_k < $1 AND calificacionr_k < $1;',[cali])).rows
  //  const materias2 = ( await pool.query('select cve_m,nombre_m from kardex inner join materia on kardex.fkmateria_k = cve_m where calificacionp_k < $1;',[cali])).rows

    if (materias.length > 0){
     
      res.status(200).json({
        materias:materias,

      })

    }
    else 
    res.status(200).json({
      message:"No tiene materias reprobadas"
    })

    
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({
      message: 'Error en el servidor',
      error: error.message,
    });
  }
}


inscription.materias_pasadas = async(req,res)=>{
  //materias aprobadas en primeras y segundas 
  try {
   // const id = req.params.userId;
    let cali = 6

    const materias = ( await pool.query('SELECT cve_m, nombre_m FROM kardex INNER JOIN materia ON kardex.fkmateria_k = cve_m WHERE calificacionp_k > $1 OR calificacionr_k > $1;',[cali])).rows
    //const materias2 = ( await pool.query('select cve_m,nombre_m from kardex inner join materia on kardex.fkmateria_k = cve_m where calificacionp_k > $1;',[cali])).rows

    if (materias.length > 0 ){
      res.status(200).json({
        materias:materias,
       
      })

    }
    else 
    res.status(200).json({
      message:"Arreglo vacio"
    })

    
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({
      message: 'Error en el servidor',
      error: error.message,
    });
  }
}

inscription.materias_faltantes = async(req,res)=>{
  try {
     // const id = req.params.userId;
     let cali = 6
     const materias = ( await pool.query('SELECT mpe.fkmateria_mpe, m.nombre_m, semestre_mpe FROM materiaplane mpe LEFT JOIN kardex k ON mpe.fkmateria_mpe = k.fkmateria_k LEFT JOIN materia m ON mpe.fkmateria_mpe = m.cve_m WHERE k.fkmateria_k IS NULL;')).rows
     //const materias2 = ( await pool.query('select cve_m,nombre_m from kardex inner join materia on kardex.fkmateria_k = cve_m where calificacionp_k > $1;',[cali])).rows
    // const ligada = (await pool.query('SELECT nombre_m FROM prerrequisitos INNER JOIN materia ON materia.cve_m = prerrequisitos.cvemateria_pre WHERE fkmateria_pre IN (SELECT fkmateria_k FROM kardex INNER JOIN materia ON kardex.fkmateria_k = materia.cve_m WHERE calificacionp_k < $1 AND calificacionr_k < $1);',[cali])).rows

     if (materias.length > 0 ){
       res.status(200).json({
         materias:materias,
        // ligada:ligada
        
       })
 
     }
     else 
     res.status(200).json({
       message:"Esta vacio"
     })
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({
      message: 'Error en el servidor',
      error: error.message,
    });
    
  }
}



module.exports = inscription;

# Luxury Wear

## Descripción del Proyecto

Luxury Wear es una aplicación que permite a los usuarios alquilar ropa de diseñador. Incluye los siguientes componentes:

- **Frontend**: Un proyecto en React construido con Vite y npm, que sirve como la interfaz de usuario de la aplicación.
- **Backend**: Un servicio en Java con Spring Boot que proporciona una API robusta para gestionar productos, usuarios, alquileres y pagos. Para más información, consulta la [documentación del backend](/backend/readme.md).

## Requisitos

Para ejecutar esta aplicación, asegúrate de tener instaladas las siguientes dependencias:

- **Docker Engine**: Versión 20.10.7 o superior.
  - Puedes instalar Docker Engine desde el [sitio web de Docker](https://docs.docker.com/engine/install/).
- **Docker Compose**: Versión 1.29.2 o superior.
  - Puedes instalar Docker Compose desde el [sitio web de Docker](https://docs.docker.com/compose/install/).
- **Java 17**: Necesario para ejecutar la aplicación backend.
- **Maven 3.6** o superior: Usado para construir el proyecto y gestionar sus dependencias.
- **Git Bash**: Si usas Windows, te recomendamos utilizar **Git Bash** para ejecutar los comandos en esta sección. Git Bash proporciona una terminal estilo Unix para Windows y puedes instalarlo desde [Git for Windows](https://gitforwindows.org/).

## Clonar el Repositorio

```sh
git clone https://github.com/Integrator-group-5/deployment-local.git
cd deployment-local
```

## Estructura del Proyecto

La estructura actual del proyecto es la siguiente:

```sh
deployment-local/
│
├── clone_and_run.sh     # Script para clonar los repositorios y ejecutar la aplicación
├── docker-compose.yml   # Archivo Docker Compose para orquestar los servicios
├── README.md            # Documentación del proyecto
├── frontend             # (Por crear) Frontend de la aplicación
└── backend              # (Por crear) Backend de la aplicación
```

### Nota Importante

Los directorios `backend` y `frontend` están inicialmente vacíos. Se poblarán cuando ejecutes el script `clone_and_run.sh`.

## Ejecución de la Aplicación

El proyecto incluye un script, `clone_and_run.sh`, que automatiza las siguientes tareas:

- Clonar los repositorios para los servicios de **Frontend** y **Backend** desde GitHub.
- Extraer los últimos cambios de los repositorios si ya existen localmente.
- Ejecutar `docker-compose` para construir e iniciar todos los microservicios y la instancia de MySQL requerida.

Para utilizarlo:

1. **Inicia Docker**: Asegúrate de que el daemon de Docker esté ejecutándose en tu máquina o abre **Docker Desktop** para iniciarlo.
2. En sistemas Unix (Linux y macOS), asegúrate de que el script tenga permisos de ejecución. Si no los tiene, ejecuta:

   ```sh
   chmod +x clone_and_run.sh
   ```

3. **Ejecuta el script** usando Git Bash (o cualquier shell de Bash):

   ```sh
   ./clone_and_run.sh
   ```

   Si estás en Windows y usas **Git Bash**, asegúrate de estar en el directorio raíz del proyecto donde se encuentra el archivo `clone_and_run.sh` antes de ejecutar el comando.

   El script realizará las siguientes acciones:

   - Clonar o actualizar los repositorios requeridos en sus respectivos directorios.
   - Construir imágenes Docker para cada servicio.
   - Iniciar los servicios usando Docker Compose.

- **Accede a la aplicación**:
  - Una vez iniciada, el frontend estará disponible en `http://localhost:3000`.

### Detener la Aplicación

Para detener los contenedores en ejecución, utiliza el siguiente comando:

```bash
docker-compose -f docker-compose.yml down
```

Este comando detiene y elimina los contenedores, pero mantiene los datos de la base de datos en el volumen.

### Eliminar Todos los Recursos

Si deseas detener los contenedores y también eliminar todos los recursos asociados, como volúmenes, redes e imágenes creadas por Docker Compose, ejecuta:

```bash
docker-compose -f docker-compose.yml down --volumes --rmi all
```

Este comando limpiará todos los recursos, incluidos los datos persistentes de MySQL.

## Documentación de los Scripts

### Entendiendo el Script `clone_and_run.sh`

El script `clone_and_run.sh` está diseñado para simplificar el proceso de configuración del proyecto. Aquí tienes un resumen de lo que hace:

- **Clonación de Repositorios**: Clona la última versión de cada proyecto desde su respectivo repositorio de GitHub (Frontend y Backend).
- **Actualización**: Si los repositorios ya existen localmente, el script extrae los últimos cambios en lugar de volver a clonarlos.
- **Ejecución de Docker Compose**: Una vez que todos los repositorios están clonados o actualizados, el script ejecuta `docker-compose` para construir e iniciar los contenedores Docker de la aplicación.

### Entendiendo el archivo `docker-compose.yml`

El archivo `docker-compose.yml` orquesta los servicios y sus dependencias. Define lo siguiente:

- **Instancia de MySQL**: Configura una instancia de MySQL para el `luxury-wear-service` (backend).
- **Servicios**: Los servicios `luxury-wear-frontend` y `luxury-wear-service` se construyen y ejecutan en contenedores separados.

Con Docker Compose, todos los servicios se construyen e inician juntos, asegurando un entorno consistente para la aplicación.

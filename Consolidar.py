import os


def principal():
    try:
        print("Inicio de ejecución")

        # Elimina el archivo consolidado si existe
        if os.path.exists('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql'):
            os.remove('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql')

        # Crea encabezado consolidado
        with open('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql', 'a') as encabezado:
            sqlUse = "USE SiesaRelease;"
            encabezado.write(sqlUse)
            encabezado.write("\n")
            encabezado.write("\n")
            encabezado.write("--- PROCEDIMIENTOS ALMACENADOS DE SIESA RELEASE ---")
            encabezado.write("\n")

        rutaArchivosSQL = "C:/ConsolidadoSP_SiesaRelease/procedimientosalmacenados"
        listaArchivosSQL = os.listdir(rutaArchivosSQL)
        archivos = []

        print('Copiando scripts...')

        # Recorre el directorio con los archivos SQL
        for archivo in listaArchivosSQL:
            if os.path.isfile(os.path.join(rutaArchivosSQL, archivo)) and archivo.endswith('.sql'):
                archivos.append(archivo)
        print(archivos)

        # Escribe en el consolidado
        for i in range(0, len(archivos)):
            escribirconsolidado(rutaArchivosSQL, archivos[i])

        print("Scripts adicionados correctamente!")

    except Exception as error:
        print("Ha ocurrido un error: ", error)
    finally:
        print("Fin del script")


def escribirconsolidado(rutaarchivossql, archivosql):
        # Lee cada archivo
        with open(f'{rutaarchivossql}/{archivosql}', 'r') as leido:
            # Abre el archivo para adicionar al consolidado
            with open('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql', 'a') as consolidado:
                consolidado.write("\n")
                consolidado.write("--  ******* INICIO PROCEDIMIENTO DE ALMACENADO ****** --")
                consolidado.write("\n")
                consolidado.write("\n")
                for linea in leido:
                    consolidado.write(linea)
                consolidado.write("\n")
                # consolidado.write("-- FIN PROCEDIMIENTO*************** --")


principal()

# pip install pyinstaller
# pyinstaller  --onefile Consolidar.py
# pip install auto-py-to-exe
# pyinstaller --windowed --onefile --icon=./siesa.ico Consolidar.py
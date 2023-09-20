import os


def principal():
    try:
        print("Inicio de ejecución")

        # Elimina el consolidado
        os.remove('ConsolidadoSiesaRelease.sql')

        # Crea encabezado consolidado
        with open('ConsolidadoSiesaRelease.sql', 'a') as encabezado:
            sqlUse = "USE SiesaRelease;"
            encabezado.write(sqlUse)
            encabezado.write("\n")
            encabezado.write("--- PROCEDIMIENTOS ALMACENADOS DE SIESA RELEASE ---")

        rutaArchivosSQL = "ScriptsSQLPrueba"
        listaArchivosSQL = os.listdir('../' + rutaArchivosSQL)
        archivos = []

        print('Copiando scripts...')

        # Recorre el directorio con los archivos SQL
        for archivo in listaArchivosSQL:
            if os.path.isfile(os.path.join('../' + rutaArchivosSQL, archivo)) and archivo.endswith('.sql'):
                archivos.append(archivo)
        print(archivos)

        # Escribe en el consolidado
        for i in range(0, len(archivos)):
            escribirconsolidado(rutaArchivosSQL, archivos[i])

        print("Scripts adicionados correctamente!")

    except():
        print("Ha ocurrido un error...")
    finally:
        print("Fin del script")


def escribirconsolidado(rutaarchivossql, archivosql):
    # try:
        # Lee cada archivo
        with open('../' + rutaarchivossql + '/' + archivosql, 'r') as leido:
            # Abre el archivo para adicionar al consolidado
            with open('ConsolidadoSiesaRelease.sql', 'a') as consolidado:
                consolidado.write("\n")
                for linea in leido:
                    consolidado.write(linea)
                consolidado.write("\n")
                consolidado.write("***" * 10)
    # except():
    #     print("Ha ocurrido un error al escribir en el consolidado. Verifique las rutas de lectura y escritura...")


principal()

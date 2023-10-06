import os
import chardet
import glob

def principal():
    try:
        print("Inicio de ejecución")

        # Elimina el archivo consolidado si existe
        if os.path.exists('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql'):
            os.remove('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql')

        # Crea encabezado consolidado
        with open('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql', 'a', encoding="utf-8") as encabezado:
            sqlUse = "USE SiesaRelease"
            sqlGo = "GO"
            encabezado.write(sqlUse)
            encabezado.write("\n")
            encabezado.write(sqlGo)
            encabezado.write("\n")
            encabezado.write("\n")
            encabezado.write(
                "--- PROCEDIMIENTOS ALMACENADOS DE SIESA RELEASE ---")
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

        #//////////////////////////////////
        # print("File".ljust(110), "Encoding")
        # for filename in glob.glob('C:/ConsolidadoSP_SiesaRelease/procedimientosalmacenados/*.sql'):
        #     with open(filename, 'rb') as rawdata:
        #         result = chardet.detect(rawdata.read())
        #     print(filename.ljust(110), result['encoding'])
        #///////////////////////////////

    except UnicodeDecodeError as erruni:
        print("Error: la lectura y/o escritura de los archivos deben coincidir permitiendo la compatibilidad con la codificación UTF-8: ", erruni)
    except Exception as error:
        print("Error: ", error)
    finally:
        print("Fin del script")


def escribirconsolidado(rutaarchivossql, archivosql):
    # Lee cada archivo
    with open(f'{rutaarchivossql}/{archivosql}', 'r', encoding="utf-8") as leido: #si quito el encoding salen los caracteres especiales
        # Abre el archivo para adicionar al consolidado
        with open('C:/ConsolidadoSP_SiesaRelease/ConsolidadoSiesaRelease.sql', 'a', encoding="utf-8") as consolidado:
            # consolidado.write("\n")
            consolidado.write(
                "--  ******* INICIO DE PROCEDIMIENTO ALMACENADO ****** --")
            consolidado.write("\n")
            # consolidado.write("\n")
            for linea in leido:
                consolidado.write(linea)
            consolidado.write("\n")


principal()

# pip install pyinstaller
# pyinstaller  --onefile Consolidar.py
# pip install auto-py-to-exe
# pyinstaller --clean --onefile --icon=./siesa.ico Consolidar.py

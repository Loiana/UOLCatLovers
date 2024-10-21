
import sys
import csv
import requests
import pandas as pd

#Caso o script seja executado automaticamente em uma rotina eu incluiria também incrementar o nome do arquivo csv gerado e registro de log.
#Para maior segurança e controle de ambientes, eu incluiria a url da api (token ou variaveis de autenticação, se houvessem) em um arquivo de configurações a parte.

api_url = 'https://cat-fact.herokuapp.com/facts'
file_name = 'data/CatFacts.csv'

def request_api():

    try:
        # Faz a requisição HTTP
        response = requests.get(api_url)
        
        # Levanta uma exceção se o código de status indicar erro
        response.raise_for_status()
        
        # Tenta converter o conteúdo para JSON
        api_data = response.json()

        return api_data
    
    except requests.exceptions.HTTPError as errh:
        print(f"HTTP Error: {errh}")
 
    except requests.exceptions.ConnectionError as errc:
        print(f"Error Connecting: {errc}")

    except requests.exceptions.Timeout as errt:
        print(f"Timeout Error: {errt}")

    except requests.exceptions.RequestException as err:
        print(f"An Error Occurred: {err}")

    # Retorna None em caso de falha
    return None 


def save_csv(json_data):

    try:
        # Converte JSON para DataFrame
        df = pd.DataFrame(json_data)

        # Salva o DataFrame em CSV (virgula para separar os campos e quabra de linha para separar as linhas)
        df.to_csv(file_name, index=False)

        print(f"Arquivo {file_name} salvo com sucesso.")

        return file_name

    except ValueError as ve:
        print(f"Erro ao converter dados JSON para DataFrame: {ve}")

    except IOError as ioe:
        print(f"Erro ao salvar o arquivo CSV: {ioe}")

    except Exception as e:
        print(f"Um erro inesperado ocorreu: {e}")
        
    # Retorna None em caso de falha
    return None


def main():

    print("Begin")
    print("May take a few seconds to respond...")

    data = request_api()
    #print(data)

    if data is not None:
        save_csv(data)

    print("End")


if __name__ == "__main__":

    try:
        main()

    except Exception as e:
        print(f"Critical error: {e}")

        sys.exit(1)
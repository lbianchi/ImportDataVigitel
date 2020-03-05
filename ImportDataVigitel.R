### Função para download das bases do vigitel pelo site oficial. 
### O único argumento de entrada é o ano que deseja o download.
### É possível inserir um vetor de anos que também funcionará.
### Por padrão será baixado o dicionário de dados. 
### Caso não queira baixar o dicionário, acrescente o argumento dicio = FALSE
### Os dados serão inseridos em uma pasta que será criada no diretório de trabalho chamada "Vigitel".
### Os objetos serão do tipo 'data.frame' e já estarão nomeados de acordo. 
### carrega a função:

vigitel_download <-
  function(anos,dicio = NULL){
    if(is.null(dicio)){
      dicio = T
    }
    local <- getwd()
    dir.create("Vigitel")
    novolocal <- paste0(local, "/Vigitel")
    anos <- anos
    arquivos <- paste0('Vigitel-', anos, '-peso-rake.xls')
    links <- paste0('http://svs.aids.gov.br/download/Vigitel/', arquivos)
    destino <- paste0(novolocal,"/Vigitel", anos, '.xls')
    if(dicio == T){
      download.file("http://svs.aids.gov.br/download/Vigitel/Dicionario-de-dados-Vigitel.xls", paste0(novolocal, "/dicionario.xls"),mode = "wb")
      assign("dicionario",readxl::read_xls(paste0(novolocal,"/dicionario.xls")),envir=.GlobalEnv)
    }
    for(i in 1:length(links)){
      download.file(links[i], destino[i],mode = "wb")
    }
    if(!require(readxl)) {
      install.packages("readxl")
    }
    for(i in 1:length(anos)){
      assign(paste0('Vigitel', anos[i]),data.frame(readxl::read_excel(destino[i])),envir=.GlobalEnv)
    }
  }

### e para o download dos anos de 2017 e 2018 digite:
vigitel_download(c(2015),dicio = F)


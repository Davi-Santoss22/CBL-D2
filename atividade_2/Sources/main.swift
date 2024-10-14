import Foundation

// Essa função realiza a leitura do conteúdo do arquivo
func readFile(at path: String) -> String? {
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: path) {
        return try? String(contentsOfFile: path)
    } else {
        print("Arquivo não encontrado.")
        return nil
    }
}

// Função para contar palavras
func countWords(in text: String) -> Int {
    let words = text.split { $0.isWhitespace }
    return words.count
}

// Função para buscar alguma palavra do texto
func searchWord(in text: String, word: String) -> Bool {
    return text.range(of: word, options: .caseInsensitive) != nil
}

// Função para substituir alguma palavra
func replaceWord(in text: String, oldWord: String, newWord: String) -> String {
    return text.replacingOccurrences(of: oldWord, with: newWord)
}

// Função principal
func main() {
    let arguments = CommandLine.arguments
    
    guard arguments.count > 2 else {
        print("Uso: atividade_2 <caminho_arquivo> <comando> [parâmetros]")
        return
    }

    let filePath = arguments[1]
    let command = arguments[2]
    
    guard let content = readFile(at: filePath) else { return }
    
    switch command {
    case "count":
        let wordCount = countWords(in: content)
        print("Número de palavras: \(wordCount)")
    case "search":
        guard arguments.count > 3 else {
            print("Forneça a palavra a ser buscada.")
            return
        }
        let word = arguments[3]
        let found = searchWord(in: content, word: word)
        print(found ? "Palavra encontrada." : "Palavra não encontrada.")
    case "replace":
        guard arguments.count > 4 else {
            print("Forneça a palavra antiga e a nova palavra para substituição.")
            return
        }
        let oldWord = arguments[3]
        let newWord = arguments[4]
        let newText = replaceWord(in: content, oldWord: oldWord, newWord: newWord)
        print("Texto atualizado:\n\(newText)")
    default:
        print("Comando desconhecido.")
    }
}

main()

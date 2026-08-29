//Iniciando a máquina de estados
function state() constructor {
    //Método que vai rodar ao iniciar um estado
    static start = function () {};
    //Método onde a lógica do estado vai rodar
    static run = function () {};
    //Método que finaliza o estado
    static finish = function () {};
}

//Função para o estado inicial
function start_state (_state) {
    //variável para saber o estado atual
    current_state = _state;
    current_state.start();
}

//Função para trocar de estado
function state_change (_state) {
    //Finalizando o estado atual
    current_state.finish();
    
    //Mudando o estado atual
    current_state = _state;
    
    //Iniciando o novo estado
    current_state.start();
}

//Função para rodar a lógica do estado
function run_state () {
    current_state.run();
}

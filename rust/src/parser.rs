use lexer;

pub fn parse(tokens: Vec<String>) -> Vec<String> {
    let mut operators : Vec<String> = vec![];
    let mut output_stack : Vec<String> = vec![];

    for token in tokens.iter() {
        if lexer::is_operator(token) {
            // FIXME
        } else {
            output_stack.push(String::from_str(token));
        }
    }

    return output_stack
}

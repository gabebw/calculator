use lexer;

pub fn parse(tokens: Vec<String>) -> Vec<String> {
    let mut operators : Vec<String> = vec![];
    let mut output_stack : Vec<String> = vec![];

    for &token in tokens.iter() {
        if lexer::is_operator(&token) {
            let o1 = *token;

            if operators.len() > 0 {
                let mut o2 = operators[operators.len() - 1]; // wtf

                while lexer::has_lower_precedence(&o1, &o2) {
                    operators.pop();
                    output_stack.push(o2);
                    o2 = operators[operators.len() - 1];
                }
                operators.push(String::from_str(o1));
            } else {
                operators.push(String::from_str(token));
            }
            // FIXME
        } else {
            output_stack.push(String::from_str(token));
        }
    }

    return output_stack
}

component displayname="Base bean" accessorts="true" {
    
    public any function init() {
        var properties = getMetaData( this ).properties;
        var i = 0;
        var key = '';
        var setvalue = '';

        for ( i = 1; i <= arrayLen( properties ); i++ ) {
            property = properties[ i ].name;
            propertyType = '';
            
            if ( structKeyExists( properties[ i ], 'type' ) ) {
                propertyType = properties[ i ].type;
            }
            
            if ( isDefined('this.set#property#') ) {
                if ( structKeyExists( arguments, property ) ) {
                    setvalue = arguments[ property ];
                } else if ( structKeyExists( properties[ i ], 'default' ) ) {
                    setvalue = properties[ i ]['default'];
                } else {
                    switch( propertyType ) {
                        case 'numeric':
                            setvalue = 0;
                            break;
                        case 'boolean':
                            setvalue = false;
                            break;
                        case 'array':
                            setvalue = arrayNew( 1 );
                            break;
                        case 'struct':
                            setvalue = structNew();
                            break;
                        case 'query':
                            setvalue = queryNew('');
                            break;
                        default:
                            setvalue = '';
                    }
                }
                evaluate('this.set#property#( setvalue )');
            }
        }
        
        return this;
    }
    
}
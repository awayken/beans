component extends="mxunit.framework.testcase" {
    
    function testSimpleInit() {
        var data = {
            name = "Fake name",
            value = "Fake value",
            extraProperty = "Fake property"
        };
        var bean = new beans.simplebean( argumentCollection=data );
        
        assertEquals( bean.getName(), data.name );
        assertEquals( bean.getValue(), data.value );
        assertFalse( isDefined('bean.getextraproperty'), 'extraProperty should not have a getter' );
        assertFalse( isDefined('bean.setextraproperty'), 'extraProperty should not have a setter' );
        assertFalse( isDefined('bean.extraproperty'), 'extraProperty should not have a value' );
    }
    
    function testComplicatedInit() {
        var data = {
            testString = "Fake name",
            testNumeric = 10,
            testBoolean = true,
            testDate = now(),
            testArray = [ 1, 2, 3, 4 ],
            testStruct = {
                a = 1,
                b = 2,
                c = 3
            },
            testQuery = queryNew('ID, Name, Numbers', 'integer, varchar, integer'),
            testObject = new beans.simplebean( name='Fake name' )
        };
        var bean = new beans.complicatedbean( argumentCollection=data );
        
        assertEquals( bean.gettestString(), data.testString );
        assertEquals( bean.gettestNumeric(), data.testNumeric );
        assertEquals( bean.gettestBoolean(), data.testBoolean );
        assertEquals( bean.gettestDate(), data.testDate );
        assertEquals( bean.gettestArray(), data.testArray );
        assertEquals( bean.gettestStruct(), data.testStruct );
        assertEquals( bean.gettestQuery(), data.testQuery );
        assertEquals( bean.gettestObject().getName(), 'Fake name' );
    }
    
    function testConvertJSONToSelf() {
        var bean = new beans.simplebean();
        var inJSON = '{"name":"Miles Rausch","value":"Fake value"}';
        
        makePublic( bean, 'convertJSONToSelf' );
        
        bean.convertJSONToSelf( inJSON );
        
        assertEquals( bean.getName(), 'Miles Rausch' );
        assertEquals( bean.getValue(), 'Fake value' );
    }
    
    function testConvertStructToSelf() {
        var bean = new beans.simplebean();
        var inStruct = {
            name="Miles Rausch",
            value="Fake value"
        };
        
        makePublic( bean, 'convertStructToSelf' );
        
        bean.convertStructToSelf( inStruct );
        
        assertEquals( bean.getName(), 'Miles Rausch' );
        assertEquals( bean.getValue(), 'Fake value' );
    }
    
    function testConvertQueryToSelf() {
        var bean = new beans.simplebean();
        var inQuery = queryNew('Name, Value', 'varchar, varchar');
        
        queryAddRow( inQuery, 1 );
        querySetCell( inQuery, 'Name', 'Miles Rausch' );
        querySetCell( inQuery, 'Value', 'Fake value' );
        
        makePublic( bean, 'convertQueryToSelf' );
        
        bean.convertQueryToSelf( inQuery );
        
        assertEquals( bean.getName(), 'Miles Rausch' );
        assertEquals( bean.getValue(), 'Fake value' );
    }
    
    function testSimpleShow() {
        var data = {
            name = "Fake name"
        };
        var bean = new beans.simplebean( argumentCollection=data );
        
        assertEquals( bean.show('name'), data.name );
        assertEquals( bean.show( 'name', 'Name: ' ), 'Name: ' & data.name );
        assertEquals( bean.show( 'name', 'Name: ', '.' ), 'Name: ' & data.name & '.' );
        bean.setName('');
        assertTrue( len( bean.show('name') ) == 0 );
    }
    
}
import { BadRequestException, Injectable } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { AuthoLoginDto } from './dto/login.dto';

@Injectable()
export class AuthoService {
    private _userService: UsersService;
    private _jwtService: JwtService;

    constructor(userService: UsersService, jwtService: JwtService){
        this._userService = userService;
        this._jwtService = jwtService;
    }

    login(data: AuthoLoginDto){
        const user = this._userService.find((user)=>user.Username === data.Username && user.User_password === data.User_password);
        if(!user) {
            throw new BadRequestException("Invalid username or password");
        } 
        
        const payload = {
            id: user.User_ID,
            username: user.Username,
        };
        const token = this._jwtService.sign(payload);

        return({
            message: "Login successful",
            user, token
        })
    }
}

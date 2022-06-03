import React, { useEffect, useState } from 'react';
import { slide as Menu } from 'react-burger-menu';
import '../styles/sidebar.css';
import { matchPath } from 'react-router';
import SocialIconsSidebar from './SocialIconsSidebar';
import { Link, useLocation } from 'react-router-dom';
import { Button } from 'react-bootstrap';

const Sidebar = ({authenticated, username}) => {
    const [isAuthenticatedMenu, setIsAuthenticatedMenu] = useState(false);
    useEffect(() => setIsAuthenticatedMenu(authenticated), [authenticated]);
    const { pathname } = useLocation();

    const buttonsView = {
        '/': <>
            <Link to='/account' className='buttonSideBarAccount'>Crear cuenta</Link>
            <Link to='/login' className='buttonNavSideLogin'>Iniciar Sesión</Link>

        </>,
        '/account': <>
            <Link to='/login' className='buttonNavSideLogin'>Iniciar Sesión</Link>

        </>,
        '/login': <>
            <Link to='/account' className='buttonSideBarAccount'>Crear cuenta</Link>
        </>
    }

    const handleIsAuthMenu = () => {
        if (isAuthenticatedMenu) {
            return (
                <>
                    <p>¿Deseas <a className="menu-item" href="/login">cerrar sesión</a>?</p>
                    <br />
                </>
            );
        } else {
            return buttonsView[pathname];
        }
    }

    return (
        <Menu right>
            <div className='upper-colored-box'>
                {isAuthenticatedMenu ?
                    <>
                        <span>{username.slice(2)}</span>
                        <p>Hola,</p>
                        <p>{username}</p>
                    </>
                    :
                    <span className='menu'>MENU</span>
                }
            </div>
            <div className="menuConFooter">
                <div className='menu-main'>
                    {handleIsAuthMenu()}
                </div>
                <div>
                    <SocialIconsSidebar />
                </div>
            </div>
        </Menu>
    )

}

export default Sidebar;